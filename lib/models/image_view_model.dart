import 'package:ads_n_url/models/images_model.dart';

class ImageViewModel {
  final ImageModel imageModel;

  ImageViewModel(this.imageModel);

  String getImageUrl() {
    return imageModel.imgUrl;
  }

  String getImageDes() {
    return imageModel.description;
  }

  String getImageTitle() {
    //capitalizing the first char of the title word
    String s = imageModel.title;
    s = '${s[0].toUpperCase()}${s.substring(1)}';
    return s;
  }

  //images are actually post
  //I'll update them later
  String getPostId() {
    return imageModel.postID;
  }
}
