import 'package:ads_n_url/models/image_list_view_model.dart';
import 'package:ads_n_url/models/image_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  final String url;
  final int currentIndex;
  final bool isHotUrl;

  PostPage(this.url, this.currentIndex, this.isHotUrl);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  bool isClearVisible = false;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  int counter = 0;

  List<ImageViewModel> searchResult = List();
  List<ImageViewModel> posts = List();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final postsModel = Provider.of<ImageListViewModel>(context);
    if (counter == 0) {
      postsModel.fetchPosts(widget.url, widget.isHotUrl);
      counter++;
    }
    return postsModel.posts.length > 0
        ? Column(
            children: <Widget>[
              floatingSearchBar(widget.currentIndex),
              Expanded(
                child: RefreshIndicator(
                  key: refreshKey,
                  child: searchResult.length != 0 ||
                          _editingController.text.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  Uri.parse(searchResult[index].getImageUrl())
                                          .isAbsolute
                                      ? searchResult[index].getImageUrl()
                                      : "https://via.placeholder.com/150",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(searchResult[index].getImageTitle()),
                              subtitle: Text(searchResult[index].getImageDes()),
                              trailing: Text(searchResult[index].getPostId()),
                            );
                          })
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: postsModel.posts.length,
                          itemBuilder: (context, index) {
                            posts = postsModel.posts;
                            print("instance" + posts[0].getImageTitle());
                            return ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      Uri.parse(posts[index].getImageUrl())
                                              .isAbsolute
                                          ? posts[index].getImageUrl()
                                          : "https://via.placeholder.com/150",
                                  placeholder: (context, url) => Container(
                                      padding: EdgeInsets.all(4.0),
                                      child: new CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
//                                child: Image.network(
//                                  Uri.parse(posts[index].getImageUrl())
//                                          .isAbsolute
//                                      ? posts[index].getImageUrl()
//                                      : "https://via.placeholder.com/150",
//                                  fit: BoxFit.cover,
//                                ),
                              ),
                              title: Text(posts[index].getImageTitle()),
                              subtitle: Text(posts[index].getImageDes()),
//                              trailing: Text(posts[index].getPostId()), //no need to show post id
                            );
                          }),
                  onRefresh: refreshTheContent,
                ),
              ),
            ],
          )
        : Center(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 1,
              mini: true,
              child: CircularProgressIndicator(
//                backgroundColor: Colors.white,
                  ),
              onPressed: () {},
            ),
          );
  }

  Future<Null> refreshTheContent() async {
    setState(() {
      counter = 0;
    });
    var s = await Future.delayed(Duration(seconds: 3));
    return null;
  }

  @override
  bool get wantKeepAlive => true;

  Widget floatingSearchBar(currentIndex) {
    double varHeight = 0;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
//              margin: EdgeInsets.symmetric(vertical:),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.grey.shade300),
              padding: EdgeInsets.only(left: 9),
              child: TextField(
                controller: _editingController,
                style: TextStyle(fontSize: 17),
                onTap: () {},
                onChanged: onSearchTextChanged,
                decoration: InputDecoration.collapsed(
                  hintText: widget.currentIndex == 0
                      ? "Search in hot"
                      : "Search in new",
                ),
              ),
            ),
          ),
          isClearVisible
              ? Container(
                  padding: EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap: () {
                      _editingController.text = "";
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void onSearchTextChanged(String query) {
    if (query.length > 0) {
      setState(() {
        isClearVisible = true;
      });
    } else {
      setState(() {
        isClearVisible = false;
      });
    }
    searchResult.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }

    posts.forEach((post) {
      if (post.getImageTitle().contains(query) ||
          post.getImageDes().toLowerCase().contains(query) ||
          post.getImageTitle().toLowerCase().contains(query) ||
          post.getImageDes().contains(query)) {
        searchResult.add(post);
      }
    });

    setState(() {});
  }
}
