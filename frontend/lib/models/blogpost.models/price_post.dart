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
}
