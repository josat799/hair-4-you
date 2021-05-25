import 'package:backend/backend.dart';

abstract class Post {
  Post({
    this.id,
    this.title,
    this.description,
    this.author,
    this.createdAt,
  });

  @primaryKey
  int id;

  @Column(nullable: false)
  String title;

  @Column(nullable: false)
  String description;

  @Relate(#posts)
  ManagedUser author;

  @Column(nullable: false, unique: true)
  DateTime createdAt;
}
