import 'package:ads_n_url/models/image_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  final String url;

  PostPage(this.url);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final postsModel = Provider.of<ImageListViewModel>(context);
    if (counter == 0) {
      postsModel.fetchPosts(widget.url);
      counter++;
    }
    return postsModel.posts.length > 0
        ? RefreshIndicator(
            key: refreshKey,
            child: ListView.builder(
                itemCount: postsModel.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        Uri.parse(postsModel.posts[index].getImageUrl())
                                .isAbsolute
                            ? postsModel.posts[index].getImageUrl()
                            : "https://via.placeholder.com/150",
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(postsModel.posts[index].getImageTitle()),
                    subtitle: Text(postsModel.posts[index].getImageDes()),
                  );
                }),
            onRefresh: refreshTheContent,
          )
        : Center(
            child: FloatingActionButton(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
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
}
