import 'package:flutter/material.dart';
import 'package:frontend/widgets/blogpost_widgets/blog_post_multiple.dart';

class BlogPostScreen extends StatelessWidget {
  static const ROUTENAME = '/blogposts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogPostMultiple(
        onlyVisiable: false,
      ),
    );
  }
}
