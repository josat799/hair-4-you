import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/blogpost_service.dart';
import 'package:frontend/widgets/forms_widgets/update_blogpost.dart';
import 'package:provider/provider.dart';

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
  void _openDeleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                await BlogPostService(context)
                    .deleteBlogPost(widget.blogPost.id!);
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool canEdit = false;
    User? loggedInUser = context.watch<UserAuth>().user;
    if (loggedInUser != null &&
        (loggedInUser.identical(widget.blogPost.author!))) {
      canEdit = true;
    }
    return canEdit
        ? ExpansionTile(
            key: widget.key,
            title: customTitle(),
            subtitle: customSubtitle(),
            trailing: canEdit
                ? Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.edit),
                        InkWell(
                          onTap: _openDeleteDialog,
                          child: Icon(Icons.delete, color: Colors.red),
                        )
                      ],
                    ),
                  )
                : null,
            maintainState: true,
            children: [
              UpdateBlogPost(widget.blogPost),
            ],
          )
        : ListTile(
            title: customTitle(),
            subtitle: customSubtitle(),
          );
  }

  Widget customLeading() {
    return Text('');
  }

  Widget customTitle() {
    return Center(
      child: Text.rich(
        TextSpan(text: "${widget.blogPost.title}"),
      ),
    );
  }

  Widget customSubtitle() {
    return Column(
      children: [
        Text.rich(
          TextSpan(text: "${widget.blogPost.description}"),
        ),
        Text.rich(
          TextSpan(text: "${widget.blogPost.author!.name}"),
        ),
      ],
    );
  }
}
