import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/services/post_service.dart';
import 'package:frontend/widgets/post_widgets/single_post.dart';

class MultiplePosts<T extends Post> extends StatefulWidget {
  bool? onlyVisables;

  MultiplePosts({this.onlyVisables});

  @override
  _MultiplePostsState<T> createState() => _MultiplePostsState<T>();
}

class _MultiplePostsState<T extends Post> extends State<MultiplePosts> {
  late Stream<List<T>> _stream;
  @override
  void initState() {
    _stream = _fetchPosts();
    print(T);
    super.initState();
  }

  Stream<List<T>> _fetchPosts() async* {
    yield* Stream.periodic(
      Duration(seconds: 10),
      (_) async => await PostService<T>(context).fetchPosts(),
    ).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: _stream,
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData
              ? LinearProgressIndicator()
              : Container(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => Container(
                      width: 10,
                      child: SinglePost<T>(
                        post: snapshot.data!.elementAt(index),
                        key: PageStorageKey<int>(
                          snapshot.data!.elementAt(index).id!,
                        ),
                      ),
                    ),
                    itemCount: snapshot.data!.length,
                  ),
                ),
    );
  }
}
