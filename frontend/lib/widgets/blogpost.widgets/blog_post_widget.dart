import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/services/blogpost_service.dart';

class ViewableBlogPost extends StatelessWidget {
  BlogPost? _blogPost;

  int blogPostID;
  double? height;
  double? width;

  ViewableBlogPost(this.blogPostID, {this.height, this.width});

  void _getBlogPost(BuildContext context) {
    BlogPostService(context).getBlogPostByID(blogPostID);
  }

  @override
  Widget build(BuildContext context) {
    _getBlogPost(context);
    return Card(
        child: Container(
      //width: this.width ?? double.infinity,
      //height: this.height ?? double.infinity,
      child: Row(
        children: [
          Text("${_blogPost!.title}"),
          Text("${_blogPost!.description}"),
        ],
      ),
    ));
  }
}
