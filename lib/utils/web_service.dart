import 'dart:convert';

import 'package:ads_n_url/models/images_model.dart';
import 'package:ads_n_url/utils/database_helper.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<ImageModel>> fetchStories(String hostUrl, bool isHotUrl) async {
    List<ImageModel> postsList = List();
    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.initializeDatabase();
    try {
      final response = await http.get(hostUrl);
      if (response.statusCode == 200) {
        //successfully got the data
        final body = jsonDecode(response.body);
//        print(response.body);
        final Iterable json = body['data']['children'];

        //update the data
        postsList = json.map((postdata) {
          ImageModel _model = ImageModel.fromJson(postdata);
          print(_model);
          databaseHelper.insertPost(_model, isHotUrl);
          return _model;
        }).toList();
        return postsList;
      } else {
        //these are for different thing
        //these are for other error like host is down
        ///TODO have to resolve theses
        postsList = await databaseHelper.getMyPosts(isHotUrl);
        return postsList;
      }
    } on Exception catch (exception) {
      postsList = await databaseHelper.getMyPosts(isHotUrl);
      return postsList;
    } catch (error) {
      postsList = await databaseHelper.getMyPosts(isHotUrl);
      return postsList;
    }
  }
}
