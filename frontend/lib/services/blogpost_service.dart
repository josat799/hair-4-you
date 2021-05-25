import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BlogPostService {
  final BuildContext context;

  BlogPostService(this.context);

  Future<List<BlogPost>> fetchBlogPosts({int? blogPostID}) async {
    String path;
    Map<String, String> headers;

    if (blogPostID == null) {
      path = "/blogposts";
      final clientID = context.read<UserAuth>().clientID;
      final String clientCredentials =
          const Base64Encoder().convert("$clientID:".codeUnits);
      headers = {'Authorization': 'Basic $clientCredentials'};
    } else {
      path = "/restricted/blogposts/$blogPostID";
      final String token = context.read<UserAuth>().token;
      headers = {'Authorization': 'Bearer $token'};
    }
    var response = await http.get(
        Uri.http(
          "localhost:8888",
          path,
        ),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic decodedBody = json.decode(response.body);
      if (blogPostID == null) {
        Iterable<dynamic> l = decodedBody;
        List<BlogPost> posts = List<BlogPost>.from(
            l.map((blogPost) => BlogPost.fromJson(blogPost)));
        return posts;
      } else {
        return [BlogPost.fromJson(decodedBody)];
      }
    }
    return [];
  }
}
