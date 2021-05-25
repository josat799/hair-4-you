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
  late GlobalKey<FormState> _emailKey;
  late GlobalKey<FormState> _passwordKey;
  late GlobalKey<FormState> _nameKey;
  String _password = '';

  @override
  void initState() {
    _emailKey = GlobalKey<FormState>();
    _passwordKey = GlobalKey<FormState>();
    _nameKey = GlobalKey<FormState>();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Form(
        child: MultiWizard(
          finishFunction: () {
            if (_emailKey.currentState!.validate() &&
                _passwordKey.currentState!.validate() &&
                _nameKey.currentState!.validate()) {
              _emailKey.currentState!.save();
              _nameKey.currentState!.save();
              _passwordKey.currentState!.save();
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
                    key: _nameKey,
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
                    key: _emailKey,
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
                    key: _passwordKey,
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
            WizardStep(child: TextFormField()),
          ],
        ),
      ),
    );
  }
}
