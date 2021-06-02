import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/blogpost.models/price_post.dart';

import 'package:frontend/services/post_service.dart';

class UpdatePost<T extends Post> extends StatefulWidget {
  final T post;

  UpdatePost(this.post);

  @override
  _UpdatePostState<T> createState() => _UpdatePostState<T>();
}

class _UpdatePostState<T extends Post> extends State<UpdatePost> {
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    super.initState();
  }

  void _updateVisiable(bool? checked) {
    if (T == BlogPost) {
      setState(() {
        (widget.post as BlogPost).visiable = checked!;
      });
    }
  }

  Future<void> _sendUpdate() async {
    await PostService<T>(context).updatePost(post: widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
      child: Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.post.title,
              decoration: InputDecoration(hintText: 'Title'),
              onSaved: (title) => widget.post.title = title,
            ),
            TextFormField(
              initialValue: widget.post.description,
              decoration: InputDecoration(hintText: 'Description'),
              onSaved: (description) => widget.post.description = description,
            ),
            T == PricePost
                ? TextFormField(
                    initialValue: (widget.post as PricePost).price.toString(),
                    decoration: InputDecoration(hintText: 'Price'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (price) {
                      (widget.post as PricePost).price = double.parse(price!);
                    },
                    validator: (price) {
                      if (price == null && double.tryParse(price!) == null) {
                        return 'Cannot be empty';
                      } else if (double.parse(price) <= 0) {
                        return 'Must be greater than 0';
                      }
                    },
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                T == BlogPost
                    ? SizedBox(
                        width: 200,
                        child: SwitchListTile(
                            title: Text("Should it be visiable?"),
                            value: (widget.post as BlogPost).visiable,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                (widget.post as BlogPost).visiable = value;
                              });
                            }))
                    : Container(),
                ElevatedButton(
                    onPressed: () async {
                      _key.currentState!.save();
                      await _sendUpdate();
                    },
                    child: Text('Save!')),
              ],
            )

            // TODO: Add atachment to backend
            // TextFormField(
            //   //initialValue: widget.blogPost.,
            //   decoration: InputDecoration(hintText: 'Attachment'),
            // ),
          ],
        ),
      ),
    );
  }
}
