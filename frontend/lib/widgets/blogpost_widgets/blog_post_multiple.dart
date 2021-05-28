import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/services/blogpost_service.dart';
import 'package:frontend/widgets/blogpost_widgets/blog_post_widget.dart';

class BlogPostMultiple extends StatefulWidget {
  final bool onlyVisiable;

  const BlogPostMultiple({required this.onlyVisiable});



  @override
  _BlogPostMultipleState createState() => _BlogPostMultipleState();
}

class _BlogPostMultipleState extends State<BlogPostMultiple> {
  late Stream<List<BlogPost>> _stream;

  @override
  void initState() {
    _stream = _fetchBlogPosts();
    super.initState();
  }
  
  Stream<List<BlogPost>> _fetchBlogPosts() async* {
    yield* Stream.periodic(
      Duration(seconds: 10),
      (_) async => await BlogPostService(context).fetchBlogPosts(
        onlyVisiable: widget.onlyVisiable,
      ),
    ).asyncMap((event) async => await event);
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
                      blogPost: snapshot.data!.elementAt(index),
                      key: PageStorageKey<int>(
                        snapshot.data!.elementAt(index).id!,
                      ),
                    ),
                  ),
                  itemCount: snapshot.data!.length,
                )),
    );
  }
}
