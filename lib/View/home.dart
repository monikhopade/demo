import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:webrtctrial/Model/photos_model.dart';
import 'package:webrtctrial/Model/post_bloc.dart';
import 'package:webrtctrial/Repository/Utility.dart';
import 'package:webrtctrial/api/api_call.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  List<bool> photosCheckBoxValues = [];
  bool _hasMore=true;
  int _pageNumber=1;
  bool _error=false;
  bool _loading=true;
  final int _defaultPhotosPerPageCount = 10;
  final int _nextPageThreshold = 5;
  late AmenitiesBloc _bloc;
  @override
  void initState() {
    setUp();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  setUp()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      await ApiCall.photosApiCall(_pageNumber).then((value) {
        if (value.statusCode == 200) {
            Utility.photosModelList = PhotosModel.parseList(json.decode(value.body));
          photosCheckBoxValues.add(false);
          setState(() {
            _hasMore =
                Utility.photosModelList.length == _defaultPhotosPerPageCount;
            _loading = false;
            _pageNumber = _pageNumber + 1;
            Utility.photos.addAll(Utility.photosModelList);
          });
        }
        else {
          _error = true;
        }
      });
      _bloc = AmenitiesBloc();
      setState(() {
        Utility.connectionCheck.value = true;
        isLoading = false;
      });
    }
    else{
      setState(() {
        Utility.connectionCheck.value = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(Utility.connectionCheck.value==true) {
      setUp();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading?
    const Scaffold(
        body:Center(
            child: CircularProgressIndicator()
        )
    ):
    Scaffold(
        appBar: AppBar(
          title: const Text("ListView Demo"),
        ),
        body: SafeArea(
          child:
          // Utility.photos.isEmpty?
          _error?
          /*const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      )):*/
          Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _loading = true;
                    _error = false;
                    setUp();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Error while loading post, tap to try again"),
                ),
              )):
          StreamBuilder<Object>(
              stream: _bloc.photosModelListStream,
              builder: (context, snapshot) {

                return
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                    child: ListView.separated(
                      itemCount: Utility.photos.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == Utility.photos.length - _nextPageThreshold) {
                          setUp();
                        }
                        if (index == Utility.photos.length) {
                          if (_error) {
                            return Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _loading = true;
                                      _error = false;
                                      setUp();
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text("Error while loading post, tap to try again"),
                                  ),
                                ));
                          }
                          else {
                            return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: CircularProgressIndicator(),
                                ));
                          }
                        }
                        final PhotosModel photo = Utility.photos[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(photo.title!,textAlign: TextAlign.center,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                              Image.network(
                                photo.thumbnailUrl!,
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                                height: 160,
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Checkbox(
                                    value:  photo.checkBoxValue,
                                    onChanged: (value){
                                      photo.checkBoxValue = value!;
                                      _bloc.onChangeCheckBoxValue(photo);
                                    }
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: size.height * 0.02,
                        );
                      },
                    ),
                  );
              }
          ),
        )
    );
  }
}