import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/services/blogpost_service.dart';
import 'package:frontend/widgets/blogpost_widgets/blog_post_multiple.dart';
import 'package:frontend/widgets/forms_widgets/new_blog_post_form.dart';
import 'package:frontend/widgets/login_widget.dart';

class BlogPostScreen extends StatelessWidget {
  static const ROUTENAME = '/blogposts';

  final BlogPost _blogPost = BlogPost(visiable: true);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  AlertDialog _showDialog(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 200,
        height: 200,
        child: NewBlogPostForm(
          _blogPost,
          _key,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
            onPressed: () async {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();

                try {
                  await BlogPostService(context).addBlogPost(_blogPost);
                  Navigator.pop(context);
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              }
            },
            child: Text('Save!')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Container(
          height: 50,
          child: Row(
            children: [
              Text('Add'),
              Icon(Icons.add),
            ],
          ),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: _showDialog,
        ),
        tooltip: 'Add new blog post',
      ),
      appBar: AppBar(
        title: Text('All Posts'),
        actions: [
          Login(),
        ],
      ),
      body: BlogPostMultiple(
        onlyVisiable: false,
      ),
    );
  }
}
