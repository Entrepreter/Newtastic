import 'dart:convert';

import 'package:ads_n_url/models/images_model.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<ImageModel>> fetchStories(String hostUrl) async {
    final response = await http.get(hostUrl);
    if (response.statusCode == 200) {
      //successfully got the data
      final body = jsonDecode(response.body);
      print(response.body);
      final Iterable json = body['data']['children'];
      return json.map((image) => ImageModel.fromJson(image)).toList();
    } else {
      throw Exception("Could't load...");
    }
  }
}
