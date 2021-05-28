import '../backend.dart';

class PricePostController extends ResourceController {
  PricePostController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getpricePost() async {
    final query = Query<ManagedPricePost>(context)
      ..join<ManagedUser>(object: (pricePost) => pricePost.author)
          .returningProperties(
        (user) => [
          user.name,
        ],
      )
      ..sortBy((pricePost) => pricePost.createdAt, QuerySortOrder.ascending);

    return Response.ok(await query.fetch());
  }

  @Operation.get('id')
  Future<Response> getpricePostByID(@Bind.path('id') int id) async {
    final query = Query<ManagedPricePost>(context)
      ..where((pricePost) => pricePost.id).equalTo(id);

    final pricePost = await query.fetchOne();

    if (pricePost == null) {
      return Response.notFound();
    }
    return Response.ok(pricePost);
  }

  @Operation.post()
  Future<Response> addPricePost(
      @Bind.body(ignore: ["id", "createdAt"])
          ManagedPricePost pricePost) async {

    if (request.authorization.ownerID == null) {
      return Response.forbidden();
    }

    final query = Query<ManagedPricePost>(context)
      ..values = pricePost
      ..values.author.id = request.authorization.ownerID
      ..values.createdAt = DateTime.now();

    return Response.ok(await query.insert());
  }

  @Operation.put('id')
  Future<Response> updatepricePost(@Bind.path('id') int id,
      @Bind.body(ignore: ["id"]) ManagedPricePost pricePost) async {
    if (request.authorization.ownerID == null) {
      return Response.forbidden();
    }
    final query = Query<ManagedPricePost>(context)
      ..where((pricePost) => pricePost.id).equalTo(id)
      ..values = pricePost;
    return Response.ok(await query.updateOne());
  }

  @Operation.delete('id')
  Future<Response> deletepricePostByID(@Bind.path('id') int id) async {
    if (request.authorization.ownerID == null) {
      return Response.forbidden();
    }
    final query = Query<ManagedPricePost>(context)
      ..where((pricePost) => pricePost.id).equalTo(id);

    final pricePost = await query.fetchOne();

    if (pricePost == null) {
      return Response.notFound();
    }
    return Response.ok(await query.delete());
  }
}
