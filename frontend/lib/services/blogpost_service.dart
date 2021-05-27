import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BlogPostService {
  final BuildContext context;

  BlogPostService(this.context);

  Future<List<BlogPost>> fetchBlogPosts({bool? onlyVisiable}) async {
    const String path = "/blogposts";

    final String clientCredentials = const Base64Encoder()
        .convert("${context.read<UserAuth>().clientID}:".codeUnits);

    Map<String, String> headers = {'Authorization': 'Basic $clientCredentials'};
    Map<String, String> params = {'visiable': ""};

    http.Response response = await http.get(
        Uri.http("localhost:8888", path,
            onlyVisiable != null && onlyVisiable ? params : null),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic decodedBody = json.decode(response.body);
      Iterable<dynamic> l = decodedBody;
      List<BlogPost> posts =
          List<BlogPost>.from(l.map((blogPost) => BlogPost.fromJson(blogPost)));
      return posts;
    } else {
      throw Exception('No post available');
    }
  }

  Future<List<BlogPost>> fetchBlogPostBYID({required int blogPostID}) async {
    final String path = "/restricted/blogposts/$blogPostID";

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${context.read<UserAuth>().token}'
    };
    http.Response response = await http.get(
        Uri.http(
          "localhost:8888",
          path,
        ),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic decodedBody = json.decode(response.body);

      Iterable<dynamic> l = decodedBody;
      List<BlogPost> posts =
          List<BlogPost>.from(l.map((blogPost) => BlogPost.fromJson(blogPost)));
      return posts;
    } else {
      throw Exception('No posts avaiable');
    }
  }

  Future<void> updateBlogPost({required BlogPost blogPost}) async {
    final String path = "/restricted/blogposts/${blogPost.id}";

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${context.read<UserAuth>().token}',
      'Content-Type': 'application/json',
    };
    final data = jsonEncode(blogPost.toJson());
    http.Response response = await http.put(
      Uri.http(
        "localhost:8888",
        path,
      ),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200)
      return;
    else
      throw Exception('Something went wrong');
  }
  }
}
