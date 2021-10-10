import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:webrtctrial/View/home.dart';
import 'Repository/utility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  Stream<ConnectivityResult> connectivityStream = Connectivity().onConnectivityChanged;
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
      builder: (context, child) {
        return StreamBuilder<ConnectivityResult>(
            stream: connectivityStream,
            builder: (context, snapshot) {
              var connectivityResult = snapshot.data;
              if (connectivityResult == ConnectivityResult.none || connectivityResult == null) {
                return Scaffold(
                  body: SafeArea(
                    child:Center(
                        child: InkWell(
                          child: const Text("Please check internet connection & try again"),
                          onTap: ()async{
                            await Utility.checkNetworkConnectivity().then((value){
                                Utility.connectionCheck.value = value;
                                if(Utility.connectionCheck.value==true){
                                }
                            });
                          },
                        )
                    )
                  ),
                );
              }
              return const MyHomePage();
            }
        );
      }
    );
  }
}


