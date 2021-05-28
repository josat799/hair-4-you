import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';

class NewBlogPostForm extends StatefulWidget {
  final BlogPost _blogPost;

  final GlobalKey<FormState> _key;

  NewBlogPostForm(this._blogPost, this._key);

  @override
  _NewBlogPostFormState createState() => _NewBlogPostFormState();
}

class _NewBlogPostFormState extends State<NewBlogPostForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._key,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (title) {
              if (title!.isEmpty)
                return 'Cannot be empty!';
              else if (title.length < 2)
                return 'Must be longer than 2 charachters!';
            },
            onSaved: (title) {
              setState(() {
                widget._blogPost.title = title;
              });
            },
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (description) {
              if (description!.isEmpty)
                return 'Cannot be empty!';
              else if (description.length < 2)
                return 'Must be longer than 2 charachters!';
            },
            onSaved: (description) {
              setState(() {
                widget._blogPost.description = description;
              });
            },
            decoration: InputDecoration(hintText: 'Description'),
          ),
          SwitchListTile(
            value: widget._blogPost.visiable,
            onChanged: (checked) => setState(
              () {
                widget._blogPost.visiable = checked;
              },
            ),
          ),
        ],
      ),
    );
  }
}
