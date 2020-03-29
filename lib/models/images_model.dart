class ImageModel {
  String imgUrl; //url of the  thumbnail
  String title; // this is the sub reddit ,search query
  String description; //this is the title

  ImageModel({this.imgUrl, this.title, this.description});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
//    print(json);
    return ImageModel(
        imgUrl: json['data']['thumbnail'],
        title: json['data']['subreddit'],
        description: json['data']['title']);
  }
}
