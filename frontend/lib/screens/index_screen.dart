import 'package:flutter/material.dart';
import 'package:frontend/models/blogpost.models/blog_post.dart';
import 'package:frontend/models/blogpost.models/price_post.dart';
import 'package:frontend/widgets/custom_app_bar.dart';
import 'package:frontend/widgets/post_widgets/multiple_post.dart';

class IndexScreen extends StatefulWidget {
  static const ROUTENAME = '/';
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.APPBAR(context),
      body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          Center(
            child: Card(
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Messages'),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: MultiplePosts<BlogPost>(
                      updateFrequency: 10,
                      onlyVisables: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Prices'),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: MultiplePosts<PricePost>(
                      updateFrequency: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
