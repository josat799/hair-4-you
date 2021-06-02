import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/user.dart';

class PricePost extends Post {
  double price;

  PricePost({
    required this.price,
    int? id,
    String? title,
    String? description,
    User? author,
    DateTime? createdAt,
  }) : super(
          id,
          title,
          description,
          author,
          createdAt,
        );

  PricePost.fromJson(Map<String, dynamic> json)
      : this.price = json['price'],
        super(
          json['id'],
          json['title'],
          json['description'],
          User.fromJson(json['author']),
          DateTime.parse(json['createdAt']),
        );

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }
}
