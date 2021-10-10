import 'package:http/http.dart'as http;

class ApiCall{

  static Future photosApiCall(int _pageNumber)async {
    return http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber")).then(
        (http.Response response){
          return response;
      });
  }
}