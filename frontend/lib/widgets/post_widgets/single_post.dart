import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/models/blogpost.models/price_post.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/post_service.dart';
import 'package:frontend/widgets/forms_widgets/update_post.dart';
import 'package:provider/provider.dart';

class SinglePost<T extends Post> extends StatefulWidget {
  final T post;
  final EdgeInsetsGeometry? padding;

  final Key? key;

  SinglePost({
    required this.post,
    this.key,
    this.padding,
  });

  @override
  _SinglePostState<T> createState() => _SinglePostState<T>();
}

class _SinglePostState<T extends Post> extends State<SinglePost> {
  @override
  void initState() {
    super.initState();
  }

  bool _canEdit() {
    User? loggedInUser = context.watch<UserAuth>().user;
    return (loggedInUser != null &&
        (loggedInUser.identical(widget.post.author!) ||
            loggedInUser.role != Role.customer));
  }

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
                await PostService<T>(context).deletePost(widget.post.id!);
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

  Widget _editableTile() {
    return Container(
      padding: widget.padding,
      child: ExpansionTile(
        key: widget.key,
        leading: Container(
          child: customLeading(),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
        ),
        title: Container(
          child: customTitle(),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
        ),
        subtitle: Container(
          child: customSubtitle(),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
        ),
        trailing: _canEdit()
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
          UpdatePost<T>(widget.post as T),
        ],
      ),
    );
  }

  Widget _nonEditableTile() {
    return ListTile(
      leading: customLeading(),
      title: customTitle(),
      subtitle: customSubtitle(),
    );
  }

  Widget customLeading() {
    return Text.rich(
      TextSpan(
          text:
              T == BlogPost ? null : '${(widget.post as PricePost).price} kr'),
    );
  }

  Widget customTitle() {
    return Center(
      child: Text.rich(
        TextSpan(text: "${widget.post.title}"),
      ),
    );
  }

  Widget customSubtitle() {
    return Column(
      children: [
        Text.rich(
          TextSpan(text: "${widget.post.description}"),
        ),
        T == BlogPost
            ? Text.rich(
                TextSpan(text: "${widget.post.author!.name}"),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _canEdit() ? _editableTile() : _nonEditableTile();
  }
}
