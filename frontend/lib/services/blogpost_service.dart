import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';

class BlogPostService {
  final BuildContext context;
  final List<BlogPost> _blogPost = [
    BlogPost(
      1,
      "Hi",
      "",
      null,
      DateTime.now().subtract(
        Duration(days: 1),
      ),
    ),
    BlogPost(
      2,
      "Hello World!",
      "Hello and welcome to the world!",
      null,
      DateTime.now(),
    ),
  ];
  BlogPostService(this.context);

  BlogPost getBlogPostByID(int id) {
    return _blogPost.firstWhere((element) => element.id == id);
  }

  List<BlogPost> fetchBlogPost() {
    //TODO: make request to backend
    return _blogPost;
  }
}
