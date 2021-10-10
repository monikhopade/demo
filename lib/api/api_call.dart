import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:webrtctrial/Repository/utility.dart';

class ApiCall{

  static Future photosApiCall(int _pageNumber)async {
    return http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber")).then(
        (http.Response response){
// print(response.body);

          print(Utility.photosModelList.length);
          return response;
      });
  }
}