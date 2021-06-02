import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/blogpost.models/price_post.dart';
import 'package:frontend/services/post_service.dart';

class NewPostForm extends StatefulWidget {
  final Function _popDialog;

  NewPostForm(
    this._popDialog,
  );

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  int _currentIndex = 0;

  late GlobalKey<FormState> _key;

  late Post _post;

  late List<Function> _pages;

  @override
  initState() {
    _key = GlobalKey<FormState>();
    _pages = [
      _buildBlogPostForm,
      _buildPricePostForm,
    ];
    super.initState();
  }

  Widget _buildBlogPostForm() {
    _post = BlogPost(visiable: true);
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Title'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (title) {
              _post.title = title;
            },
            validator: (title) {
              if (title == null || title.isEmpty) {
                return 'Cannot be empty';
              }
            },
          ),
          TextFormField(
              decoration: InputDecoration(hintText: 'Description'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (description) {
                _post.description = description;
              },
              validator: (description) {
                if (description == null || description.isEmpty) {
                  return 'Cannot be empty';
                }
              }),
          SwitchListTile(
              title: Text("Should it be visiable?"),
              value: (_post as BlogPost).visiable,
              onChanged: (value) {
                print(value);
                setState(() {
                  (_post as BlogPost).visiable = value;
                });
              })
        ],
      ),
    );
  }

  Widget _buildPricePostForm() {
    _post = PricePost(price: 0.0);
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Title'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (title) {
              _post.title = title;
            },
            validator: (title) {
              if (title == null || title.isEmpty) {
                return 'Cannot be empty';
              }
            },
          ),
          TextFormField(
              decoration: InputDecoration(hintText: 'Description'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (description) {
                _post.description = description;
              },
              validator: (description) {
                if (description == null || description.isEmpty) {
                  return 'Cannot be empty';
                }
              }),
          TextFormField(
              decoration: InputDecoration(hintText: 'Price'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (price) {
                (_post as PricePost).price = double.parse(price!);
              },
              validator: (price) {
                if (price == null && double.tryParse(price!) == null) {
                  return 'Cannot be empty';
                } else if (double.parse(price) <= 0) {
                  return 'Must be greater than 0';
                }
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _currentIndex == 0
                  ? null
                  : () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
              child: Text("New Blog Post"),
            ),
            TextButton(
              onPressed: _currentIndex == 1
                  ? null
                  : () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
              child: Text("New Price Post"),
            ),
          ],
        ),
        _pages[_currentIndex].call(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => widget._popDialog(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  _key.currentState!.save();

                  print(_post);

                  await (_post.runtimeType == PricePost
                          ? PostService<PricePost>(context)
                          : PostService<BlogPost>(context))
                      .addPost(_post);
                  widget._popDialog(context);
                }
              },
              child: Text('Save'),
            )
          ],
        ),
      ],
    );
  }
}
