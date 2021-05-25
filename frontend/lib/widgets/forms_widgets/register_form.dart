import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late GlobalKey<FormState> _key;
  Map<String, dynamic> userCredentials = {};
  String password = "";
  int _currentStep = 0;

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> registerForm = [
      Step(
        content: Container(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please write your password again';
              } else if (value.contains(password)) {
                return 'The password does not match';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Password again',
            ),
            obscureText: true,
          ),
        ),
        title: Text(''),
      ),
      Step(
        content: TextFormField(
          onSaved: (value) {
            userCredentials['name'] = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill in your name';
            }
            return null;
          },
          decoration: const InputDecoration(hintText: 'Your Name'),
        ),
        title: Text(''),
      ),
    ];
    return SizedBox(
      width: 250,
      height: 250,
      child: Stepper(
        steps: registerForm,
        type: StepperType.horizontal,
        currentStep: _currentStep,
      ),
    );
  }
}
