import 'package:flix/utils/colors.dart';
import 'package:flix/widgets/custom_text_field.widget.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final BoxConstraints box;
  final Function(Map<String, Object> form) callback;

  const LoginForm({Key? key, required this.box, required this.callback}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, Object> form = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            title: 'Email',
            obscure: false,
            onSaved: (val) {
              form['email'] = val?.trim() ?? '';
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter an email address';
              }
              if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                  .hasMatch(val)) {
                return 'Invalid email address';
              }
              return null;
            },
          ),
          CustomTextField(
            title: 'Password',
            obscure: true,
            onSaved: (val) {
              form['password'] = val?.trim() ?? '';
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter password';
              }
              if (!RegExp(r"(?=.*\d)(?=.*[A-Z])(?=.*[a-z])((?=.*[^\w\d\s:])|(?=.*[_]))([^\s])*")
                  .hasMatch(val)) {
                return 'Password does not meet requirements \nPassword must be at least eight characters \nPassword must have one letter \nPassword must have one number \nPassword must have one symbol';
              }
              return null;
            },
          ),
          Container(
              height: 80,
              width: widget.box.maxWidth * 0.7,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: paletteYellow,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  formKey.currentState!.save();
                  if (formKey.currentState!.validate()) {
                    widget.callback(form);
                  }
                },
              )),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.grey[300]),
            ),
          ),
        ],
      ),
    );
  }
}
