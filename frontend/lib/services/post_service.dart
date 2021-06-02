import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/blogpost.models/price_post.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PostService<T extends Post> {
  final BuildContext context;

  PostService(this.context);

  Future<List<T>> fetchPosts({bool? onlyVisiable}) async {
    String path = T == BlogPost ? "/blogposts" : "/priceposts";
    final String clientCredentials = const Base64Encoder()
        .convert("${context.read<UserAuth>().clientID}:".codeUnits);

    Map<String, String> headers = {'Authorization': 'Basic $clientCredentials'};
    Map<String, String> params = {'visiable': ""};

    http.Response response;

    try {
      response = await http.get(
          Uri.http("localhost:8888", path,
              onlyVisiable != null && onlyVisiable ? params : null),
          headers: headers);
    } on Exception catch (e) {
      return [];
    }

    if (response.statusCode == 200) {
      dynamic decodedBody = json.decode(response.body);

      Iterable<dynamic> l = decodedBody;
      if (T == BlogPost) {
        return List<T>.from(l.map((post) => BlogPost.fromJson(post)));
      } else if (T == PricePost) {
        return List<T>.from(l.map((post) => PricePost.fromJson(post)));
      } else {
        return [];
      }
    } else if (response.statusCode == 404) {
      throw Exception('Could not find the post');
    } else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<List<T>> fetchPostBYID({required int postID}) async {
    String path = "/restricted" +
        (T == BlogPost ? "/blogposts" : "/priceposts") +
        "/${postID}";

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
      List<T> posts = List<T>.from(
        l.map(
          (post) {
            if (T == BlogPost) {
              return BlogPost.fromJson(post);
            } else {
              return PricePost.fromJson(post);
            }
          },
        ),
      );
      return posts;
    } else if (response.statusCode == 404) {
      throw Exception('Could not find the post');
    } else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<void> updatePost({required Post post}) async {
    String path = "/restricted" +
        (T == BlogPost ? "/blogposts" : "/priceposts") +
        "/${post.id}";

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${context.read<UserAuth>().token}',
      'Content-Type': 'application/json',
    };
    final data = jsonEncode(post.toJson());
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
    else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<void> deletePost(int postID) async {
    String path = "/restricted" +
        (T == BlogPost ? "/blogposts" : "/priceposts") +
        "/${postID}";

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${context.read<UserAuth>().token}'
    };
    http.Response response = await http.delete(
        Uri.http(
          "localhost:8888",
          path,
        ),
        headers: headers);

    if (response.statusCode == 200)
      return;
    else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<void> addPost(Post post) async {
    String path =
        "/restricted" + (T == BlogPost ? "/blogposts" : "/priceposts");
    print(path);
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${context.read<UserAuth>().token}',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode(post.toJson());

    print(body);

    http.Response response = await http.post(
        Uri.http(
          "localhost:8888",
          path,
        ),
        headers: headers,
        body: body);

    if (response.statusCode == 200)
      return;
    else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }
}
