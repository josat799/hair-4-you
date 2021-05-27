import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/services/blogpost_service.dart';

class UpdateBlogPost extends StatefulWidget {
  final BlogPost blogPost;
  

  UpdateBlogPost(this.blogPost);

  @override
  _UpdateBlogPostState createState() => _UpdateBlogPostState();
}

class _UpdateBlogPostState extends State<UpdateBlogPost> {
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    _key = GlobalKey<FormState>();

    super.initState();
  }

  void _updateVisiable(bool? checked) {
    setState(() {
      widget.blogPost.visiable = checked!;
    });
  }

  Future<void> _sendUpdate() async {
    await BlogPostService(context).updateBlogPost(blogPost: widget.blogPost);
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
              initialValue: widget.blogPost.title,
              decoration: InputDecoration(hintText: 'Title'),
              onSaved: (title) => widget.blogPost.title = title,
            ),
            TextFormField(
              initialValue: widget.blogPost.description,
              decoration: InputDecoration(hintText: 'Description'),
              onSaved: (description) =>
                  widget.blogPost.description = description,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: CheckboxListTile(
                    value: widget.blogPost.visiable,
                    onChanged: _updateVisiable,
                    title: Text('Visiable'),
                  ),
                ),
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
