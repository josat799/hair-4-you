import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/blogpost.models/price_post.dart';
import 'package:frontend/services/post_service.dart';
import 'package:frontend/widgets/forms_widgets/new_post_form.dart';
import 'package:frontend/widgets/login_widget.dart';
import 'package:frontend/widgets/post_widgets/multiple_post.dart';

class PostScreen extends StatelessWidget {
  static const ROUTENAME = '/posts';

  void popDialog(BuildContext context) {
    Navigator.pop(context);
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  AlertDialog _showDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new post'),
      content: Container(
        width: 200,
        child: NewPostForm(
          popDialog,
        ),
      ),
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
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text('Blog Posts'),
          ),
          MultiplePosts<BlogPost>(
            width: 400,
            updateFrequency: 10,
            onlyVisables: false,
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Prices'),
          ),
          MultiplePosts<PricePost>(
            width: 400,
            updateFrequency: 10,
          )
        ],
      ),
    );
  }
}
