class ImageModel {
  String imgUrl; //url of the  thumbnail
  String title; // this is the sub reddit ,search query
  String description; //this is the title
  String postID; //id for for individual post

  ImageModel({this.imgUrl, this.title, this.description, this.postID});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
//    print(json);
    return ImageModel(
        imgUrl: json['data']['thumbnail'],
        title: json['data']['subreddit'],
        description: json['data']['title'],
        postID: json['data']['id']);
  }

  // json on server is in the form imageModel('thumbnail, '......')'
  factory ImageModel.fromMap(Map<String, dynamic> json) {
//    print(json);
    return ImageModel(
        imgUrl: json['thumbnail'],
        title: json['subreddit'],
        description: json['title'],
        postID: json['id']);
  }

  //json  in sqlite is saved as ("img_url",'title','description','post_id')
  factory ImageModel.fromDatabaseMap(Map<String, dynamic> json) {
//    print(json);
    return ImageModel(
        imgUrl: json['img_url'],
        title: json['title'],
        description: json['description'],
        postID: json['post_id']);
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['post_id'] = this.postID;
    map['description'] = this.description;
    map['title'] = this.title;
    map['img_url'] = this.imgUrl;
    return map;
  }
}
