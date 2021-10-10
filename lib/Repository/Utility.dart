import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:webrtctrial/Model/photos_model.dart';

class Utility{

  static List<PhotosModel> photosModelList = [];
  static List<PhotosModel> photos = [];
  static ValueNotifier<bool> connectionCheck = ValueNotifier<bool>(true);

  static Future checkNetworkConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network.
      return true;
    }
    else if(connectivityResult == ConnectivityResult.none){
      return false;
    }
  }
}