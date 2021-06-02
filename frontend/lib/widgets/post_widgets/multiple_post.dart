import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/post.dart';
import 'package:frontend/services/post_service.dart';
import 'package:frontend/widgets/post_widgets/single_post.dart';

class MultiplePosts<T extends Post> extends StatefulWidget {
  final bool? onlyVisables;

  // How often it should retive data from the server in seconds
  final int updateFrequency;

  final double? width;
  final double? height;
  final BoxDecoration? decoration;

  MultiplePosts({
    required this.updateFrequency,
    this.onlyVisables,
    this.width,
    this.height,
    this.decoration,
  });

  @override
  _MultiplePostsState<T> createState() => _MultiplePostsState<T>();
}

class _MultiplePostsState<T extends Post> extends State<MultiplePosts> {
  late Stream<List<T>> _stream;
  @override
  void initState() {
    _stream = _fetchPosts();
    super.initState();
  }

  Stream<List<T>> _fetchPosts() async* {
    yield* Stream.periodic(
      Duration(seconds: widget.updateFrequency),
      (_) async => await PostService<T>(context).fetchPosts(
        onlyVisiable: widget.onlyVisables,
      ),
    ).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<T>>(
        stream: _stream,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData
                ? LinearProgressIndicator()
                : Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (ctx, index) => SinglePost<T>(
                        post: snapshot.data!.elementAt(index),
                        key: PageStorageKey<int>(
                          snapshot.data!.elementAt(index).id!,
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  ),
      ),
    );
  }
}
