import 'package:backend/backend.dart';
import 'post.dart';

class ManagedBlogPost extends ManagedObject<BlogPost> implements BlogPost {}

@Table(name: 'Blogpost')
class BlogPost extends Post {
  BlogPost(
    int id,
    String title,
    String description,
    ManagedUser author,
    DateTime createdAt,
  ) : super(
          id: id,
          title: title,
          description: description,
          author: author,
          createdAt: createdAt,
        );
}
