import 'package:flutter/material.dart';
import 'package:frontend/widgets/login_widget.dart';

class Hair4YouPage extends StatefulWidget {
  @override
  _Hair4YouPageState createState() => _Hair4YouPageState();
}

class _Hair4YouPageState extends State<Hair4YouPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hair for You'),
        actions: [
          Login(),
        ],
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
