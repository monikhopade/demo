import 'dart:async';

import 'package:webrtctrial/Model/photos_model.dart';
import 'package:webrtctrial/Repository/Utility.dart';

class AmenitiesBloc {

  final postListStreamController = StreamController<List<PhotosModel>>();

  final postCheckBoxValueChangeController = StreamController<PhotosModel>();

  Stream<List<PhotosModel>> get photosModelListStream => postListStreamController.stream;
  StreamSink<List<PhotosModel>> get photosModelListSink => postListStreamController.sink;

  StreamSink<PhotosModel> get photosModelCheckboxValueSink => postCheckBoxValueChangeController.sink;


  AmenitiesBloc() {
    // Initial data for list and map
    postListStreamController.add(Utility.photos);
    postCheckBoxValueChangeController.stream.listen(onChangeCheckBoxValue);
  }
  onChangeCheckBoxValue(PhotosModel photosModel){
    bool checkboxValue = photosModel.checkBoxValue;
    int postIndex = Utility.photos.indexWhere((e)=>e.id == photosModel.id);
    Utility.photos[postIndex].checkBoxValue = checkboxValue;
    photosModelListSink.add(Utility.photos);
  }

  void dispose(){
    postListStreamController.close();
    postCheckBoxValueChangeController.close();
  }

}