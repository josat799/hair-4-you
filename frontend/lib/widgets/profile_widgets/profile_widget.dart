import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';

class Profile extends StatelessWidget {
  final User user;

  Profile(this.user);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Card(
        child: Column(
          children: [
            Text('Hello ${user.name}'),
            Text('Your phonenumber is: ${user.phoneNumber}'),
            Text('Your email is: ${user.email}'),
            Text('Your birthdate is: ${user.birthDate}'),
          ],
        ),
      ),
    );
  }
}
