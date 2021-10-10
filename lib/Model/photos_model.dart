class PhotosModel {
  int? albumId;
  int id=0;
  String? title;
  String? url;
  String? thumbnailUrl;
  bool checkBoxValue=false;

  PhotosModel(
      {this.albumId,required this.id,this.title, this.url,this.thumbnailUrl,required this.checkBoxValue});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
  static List<PhotosModel> parseList(List<dynamic> list) {
    return list.map((i) => PhotosModel.fromJson(i)).toList();
  }
}