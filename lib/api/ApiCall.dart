import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:webrtctrial/Model/photosModel.dart';
import 'package:webrtctrial/Repository/Utility.dart';

class ApiCall{

  static Future photosApiCall()async {
print("url");
    await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos")).then(
        (http.Response response){
          if(response.statusCode==200) {
            PhotosModel photosModel = PhotosModel();
            for(int i=0;i<json.decode(response.body).length;i++){
              photosModel = PhotosModel.fromJson(json.decode(response.body)[i]);
              Utility.photoesModelList.add(photosModel);
            }
          }
          print("return");
          return response;
      });
  }
}