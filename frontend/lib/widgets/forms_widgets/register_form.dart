import 'package:flutter/material.dart';

import 'package:frontend/models/user.dart';
import 'package:multi_wizard/multi_wizard.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm(this.signUpFunction);

  @override
  _RegisterFormState createState() => _RegisterFormState();
  final Future<void> Function(User user) signUpFunction;
}

class _RegisterFormState extends State<RegisterForm> {
  DateTime selectedDate = DateTime.now();
  late User _user;
  late GlobalKey<FormState> _key;

  String _password = '';

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Form(
        key: _key,
        child: MultiWizard(
          finishFunction: () {
            if (_key.currentState!.validate()) {
              _key.currentState!.save();

              widget.signUpFunction(_user);
            }
          },
          steps: [
            WizardStep(
              showPrevious: false,
              nextFunction: () {},
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) => _user.name = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill in your name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Your Name'),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please write your email';
                      } else if (!value.contains('@')) {
                        return 'Please provide an correct email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _user = User(email: value!);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please choose a password!';
                      }
                      _password = value;
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty || value != _password) {
                        return 'The password does not match';
                      }
                    },
                    onSaved: (value) => _user.password = value,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password Again',
                    ),
                  ),
                ],
              ),
            ),
            WizardStep(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Your Birthdate (E.g 1997-05-30)',
                    ),
                    validator: (value) {
                      if (DateTime.tryParse(value!) == null) {
                        return 'Try putting in a correct date';
                      }
                    },
                    onSaved: (value) {
                      _user.birthDate = DateTime.parse(value!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
