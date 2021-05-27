import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';

class SingleBlogPost extends StatefulWidget {
  final BlogPost blogPost;
  final Key? key;

  SingleBlogPost({
    required this.blogPost,
    this.key,
  });

  @override
  _SingleBlogPostState createState() => _SingleBlogPostState();
}

class _SingleBlogPostState extends State<SingleBlogPost> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Center(child: Text("${widget.blogPost.title}")),
      subtitle: Column(
        children: [
          Text("${widget.blogPost.description}"),
          Text("${widget.blogPost.author!.name}"),
        ],
      ),
      trailing: Icon(Icons.edit),
      maintainState: true,
      children: [
        TextFormField(),
        TextFormField(),
        TextFormField(),
      ],
    );
  }
}
