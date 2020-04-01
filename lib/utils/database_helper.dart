import 'dart:io';

import 'package:ads_n_url/models/images_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String hotPostTable = 'hot_post_table';
  String newPostTable = 'new_post_table';
  String postId = 'post_id';
  String postImageUrl = 'img_url';
  String title = 'title';
  String description = 'description';

  DatabaseHelper._createInstance();

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<void> deleteTable(bool isHot) async {
    Database db = await this.database;
    if (isHot) {
      db.delete(hotPostTable);
    } else {
      db.delete(newPostTable);
    }

    print('deleted');
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "newtastic.db";

    var newtasticDatabase =
        await openDatabase(path, onCreate: _createDb, version: 1);

    return newtasticDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $hotPostTable($postId TEXT, $title TEXT, $description TEXT, $postImageUrl TEXT)');
    await db.execute(
        'CREATE TABLE $newPostTable($postId TEXT, $title TEXT, $description TEXT, $postImageUrl TEXT)');
  }

//  getPosts() async {
//    Database db = await this.database;
//    var result = await db.query(hotPostTable);
//    return result;
//  }

  Future<List<ImageModel>> getMyPosts(bool isHot) async {
    Database db = await this.database;
    var table;
    if (isHot) {
      table = await db.query(hotPostTable);
    } else {
      table = await db.query(newPostTable);
    }
    List<ImageModel> posts = List();
    for (int i = 0; i < table.length; i++) {
      posts.add(ImageModel.fromDatabaseMap(table[i]));
    }

    return posts;
  }

  Future<int> insertPost(ImageModel imageModel, bool isHot) async {
    Database db = await this.database;
    var result;
    if (isHot) {
      result = db.insert(hotPostTable, imageModel.toMap());
      result.then((e) {
        print(e);
      });
    } else {
      result = db.insert(newPostTable, imageModel.toMap());
      result.then((e) {
        print(e);
      });
    }
    print("inserted" + imageModel.toMap().toString());
    return result;
  }

  Future<int> updatePost(ImageModel imageModel) async {
    Database db = await this.database;
    var result = db.update(hotPostTable, imageModel.toMap(),
        where: '$postId = ?', whereArgs: [postId]);
    return result;
  }

  Future<int> deletePost(ImageModel imageModel) async {
    Database db = await this.database;
    var result =
        db.delete(hotPostTable, where: '$postId = ?', whereArgs: [postId]);
    return result;
  }

//  Future<int> getCount() async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x =
//        await db.rawQuery('SELECT COUNT (*) from $postTable');
//
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }

//  Future<List<ImageModel>> getPostsList() async {
//    var postsList = await getPosts();
//    int count = postsList.length;
//
//    List<ImageModel> postList = List<ImageModel>();
//    for (int i = 0; i < count; i++) {
//      postList.add(ImageModel.fromMap(postsList[i]));
//    }
//
//    return postList;
//  }
}
