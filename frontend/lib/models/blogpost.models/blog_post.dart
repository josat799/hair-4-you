import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/user.dart';

class BlogPost extends Post {
  BlogPost(
    this.visiable,
    int? id,
    String? title,
    String? description,
    User? author,
    DateTime? createdAt,
  ) : super(
          id,
          title,
          description,
          author,
          createdAt,
        );

  BlogPost.fromJson(Map<String, dynamic> json)
      : this.visiable = json['visiable'],
        super(
          json['id'],
          json['title'],
          json['description'],
          User.fromJson(json['author']),
          DateTime.parse(json['createdAt']),
        );

  bool visiable;
}
