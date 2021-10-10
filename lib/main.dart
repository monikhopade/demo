import 'package:flutter/material.dart';

import 'Repository/Utility.dart';
import 'api/ApiCall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  List<bool> photosCheckBoxValues = [];
  @override
  void initState() {
    // TODO: implement initState
    setUp();
    super.initState();
  }
  setUp()async{
    await ApiCall.photosApiCall().then((value){
      // Utility.photoesModelList.length
      photosCheckBoxValues.add(false);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading?
    Scaffold(
      body:Center(
        child: CircularProgressIndicator()
      )
    ):Scaffold(
      appBar: AppBar(
        title: Text("ListView Demo"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
          child: ListView(
            children:[
              ListView.separated(
                shrinkWrap: true,
                  separatorBuilder:(BuildContext context,val){
                      return SizedBox(
                        height: size.height * 0.02,
                      );
                    },
                  itemCount: Utility.photoesModelList.length,
                itemBuilder: (BuildContext context,index){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(Utility.photoesModelList[index].url!)
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Checkbox(
                              value: true,
                              onChanged:(value){
                                setState(() {
                                  photosCheckBoxValues[index] = false;
                                });
                              }
                          ),
                        ),
                        Text(Utility.photoesModelList[index].title!,textAlign: TextAlign.center,),
                      ],
                    ),
                  );
                }
              ),
             /* ListView.builder(
                shrinkWrap: true,
                itemCount: 5,//Utility.photoesModelList.length,
                  itemBuilder: (BuildContext context,index){
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color:Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("url")
                        ),
                      ),
                      child: Column(
                        children: [
                          Checkbox(
                              value: true,
                              onChanged:(value){

                              }
                          ),
                          Text("",textAlign: TextAlign.center,),
                        ],
                      ),
                    );
                  }
              )*/
            ]
          ),
        ),
      ),
    );
  }
}


