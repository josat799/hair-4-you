import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Map<String, dynamic> data;

  Profile(this.data);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Card(
        child: Column(
          children: [
            Text('Hello ${data['name']}'),
            Text('Your phonenumber is: ${data['phoneNumber']}'),
            Text('Your email is: ${data['email']}'),
            Text('Your birthdate is: ${data['birthDate']}'),
          ],
        ),
      ),
    );
  }
}
