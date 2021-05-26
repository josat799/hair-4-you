import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/services/blogpost_service.dart';
import 'package:frontend/widgets/blogpost_widgets/blog_post_widget.dart';

class BlogPostMultiple extends StatefulWidget {
  @override
  _BlogPostMultipleState createState() => _BlogPostMultipleState();
}

class _BlogPostMultipleState extends State<BlogPostMultiple> {
  late Stream<List<BlogPost>> _stream;

  @override
  void initState() {
    _stream = Stream.fromFuture(_fetchBlogPosts());
    super.initState();
  }

  Future<List<BlogPost>> _fetchBlogPosts() async {
    return Future.delayed(
      Duration(milliseconds: 1000),
      () async => await BlogPostService(context).fetchBlogPosts(
        onlyVisiable: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BlogPost>>(
      stream: _stream,
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData
              ? LinearProgressIndicator()
              : Container(
                  child: ListView.builder(
                  itemBuilder: (ctx, index) => Container(
                    width: 10,
                    child: SingleBlogPost(
                      snapshot.data![index],
                    ),
                  ),
                  itemCount: snapshot.data!.length,
                )),
    );
  }
}
