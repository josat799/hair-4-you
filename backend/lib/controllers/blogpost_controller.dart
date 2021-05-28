import '../backend.dart';

class BlogPostController extends ResourceController {
  BlogPostController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getBlogPost({@Bind.query("visiable") bool visiable}) async {
    final query = Query<ManagedBlogPost>(context)
      ..join<ManagedUser>(object: (blogpost) => blogpost.author)
          .returningProperties(
        (user) => [
          user.name,
        ],
      )..sortBy((blogPost) => blogPost.createdAt, QuerySortOrder.ascending);

    if (visiable != null) {
      query.where((blogPost) => blogPost.visiable).equalTo(visiable);
    }

    return Response.ok(await query.fetch());
  }

  @Operation.get('id')
  Future<Response> getBlogPostByID(@Bind.path('id') int id) async {
    final query = Query<ManagedBlogPost>(context)
      ..where((blogPost) => blogPost.id).equalTo(id);

    final blogPost = await query.fetchOne();

    if (blogPost == null) {
      return Response.notFound();
    }
    return Response.ok(blogPost);
  }

  @Operation.post()
  Future<Response> addBlogPost(
      @Bind.body(ignore: ["id", "createdAt"]) ManagedBlogPost blogPost) async {
    if (request.authorization.ownerID == null) {
      return Response.forbidden();
    }
    final query = Query<ManagedBlogPost>(context)
      ..values = blogPost
      ..values.author.id = request.authorization.ownerID
      ..values.createdAt = DateTime.now()
      ..values.visiable = blogPost.visiable ?? true;

    return Response.ok(await query.insert());
  }

  @Operation.put('id')
  Future<Response> updateBlogPost(@Bind.path('id') int id,
      @Bind.body(ignore: ["id"]) ManagedBlogPost blogPost) async {
    if (request.authorization.ownerID == null) {
      return Response.forbidden();
    }
    final query = Query<ManagedBlogPost>(context)
      ..where((blogPost) => blogPost.id).equalTo(id)
      ..values = blogPost;
    return Response.ok(await query.updateOne());
  }

  @Operation.delete('id')
  Future<Response> deleteBlogPostByID(@Bind.path('id') int id) async {
    if (request.authorization.ownerID == null) {
      return Response.forbidden();
    }
    final query = Query<ManagedBlogPost>(context)
      ..where((blogPost) => blogPost.id).equalTo(id);

    final blogPost = await query.fetchOne();

    if (blogPost == null) {
      return Response.notFound();
    }
    return Response.ok(await query.delete());
  }
}
