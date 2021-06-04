import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_app_bar.dart';

class UnknowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.APPBAR(context),
      body: Container(
        child: Center(
          child: Text('404 Page not found'),
        ),
      ),
    );
  }
}
