import 'package:ads_n_url/models/image_list_view_model.dart';
import 'package:ads_n_url/screens/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //page controller for getting the current index the viewer is on
  final PageController _pageController = PageController();

  //changed the git account
  String t = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return ChangeNotifierProvider(
                  create: (BuildContext context) {
                    return ImageListViewModel();
                  },
                  child: index == 0
                      ? PostPage('https://www.reddit.com/hot.json', 0)
                      : PostPage('https://www.reddit.com/new.json', 1),
                );
              }),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.hot_tub), title: Text("Hot")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.new_releases), title: Text("New")),
            ],
          ),
        ),
      ),
    );
  }
}
