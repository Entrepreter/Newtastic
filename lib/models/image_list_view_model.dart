import 'package:ads_n_url/models/image_view_model.dart';
import 'package:ads_n_url/utils/web_service.dart';
import 'package:flutter/cupertino.dart';

class ImageListViewModel extends ChangeNotifier {
  List<ImageViewModel> posts = List();

  Future fetchPosts(String hostUrl) async {
    final results = await WebService().fetchStories(hostUrl);
    this.posts = results.map((item) => ImageViewModel(item)).toList();
    print(this.posts);
    notifyListeners();
  }
}
