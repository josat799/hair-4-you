import 'package:backend/backend.dart';
import 'package:backend/models/post_models/post.dart';

class ManagedPricePost extends ManagedObject<PricePost> implements PricePost {}

@Table(name: 'Pricepost')
class PricePost extends Post {
  PricePost(
    this.price,
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
  
  @Column(nullable: false)
  double price;
}