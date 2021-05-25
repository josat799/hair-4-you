import 'package:flutter/material.dart';
import 'package:multi_wizard/multi_wizard.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
  final Future<void> Function(Map<String, dynamic> userCredentials)
      signInFunction;

  LoginForm(this.signInFunction);
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> _key;
  late final List<FocusNode> _nodes;
  Map<String, dynamic> _userCredentials = {};

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _nodes = [FocusNode(), FocusNode()];
    _nodes[0].requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    for (FocusNode node in _nodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<WizardStep> _steps = [
      WizardStep(
        child: Column(
          children: [
            Container(
              child: TextFormField(
                focusNode: _nodes[0],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  _userCredentials['email'] = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill in your email';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_nodes[1]);
                },
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            TextFormField(
              focusNode: _nodes[1],
              onSaved: (value) {
                _userCredentials['password'] = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
          ],
        ),
        showPrevious: false,
      ),
    ];
    return Container(
      height: 150,
      child: Form(
        key: _key,
        child: MultiWizard.icon(
          buttonIconFinish: Icon(
            Icons.login,
            semanticLabel: 'Login',
            color: Colors.black,
          ),
          steps: _steps,
          finishFunction: () {
            if (_key.currentState!.validate()) {
              _key.currentState!.save();
              widget.signInFunction(_userCredentials);
            }
          },
        ),
      ),
    );
  }
}
