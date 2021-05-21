import 'package:frontend/models/user.dart';

abstract class Post {
  int? id;
  String? title;
  String? description;
  User? author;
  DateTime? createdAt;

  Post(
    this.id,
    this.title,
    this.description,
    this.author,
    this.createdAt,
  );
}
