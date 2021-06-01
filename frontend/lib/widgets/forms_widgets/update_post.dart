import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/post.dart';

import 'package:frontend/services/post_service.dart';

class UpdatePost<T extends Post> extends StatefulWidget {
  final T post;

  UpdatePost(this.post);

  @override
  _UpdatePostState createState() => _UpdatePostState();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                T == BlogPost
                    ? SizedBox(
                        width: 200,
                        child: CheckboxListTile(
                          value: (widget.post as BlogPost).visiable,
                          onChanged: _updateVisiable,
                          title: Text('Visiable'),
                        ),
                      )
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
