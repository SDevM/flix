import 'package:flix/widgets/custom_text_field.widget.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class RegForm extends StatefulWidget {
  final BoxConstraints box;
  final Function(Map<String, Object> form) callback;

  const RegForm({Key? key, required this.box, required this.callback}) : super(key: key);

  @override
  State<RegForm> createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
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
            title: 'Name',
            obscure: false,
            onSaved: (val) {
              form['name'] = val?.trim() ?? '';
            },
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter a username';
              } else if (val.trim().length < 5) {
                return 'Username too short';
              } else {
                return null;
              }
            },
          ),
          CustomTextField(
            title: 'Email',
            obscure: false,
            onSaved: (val) {
              form['email'] = val?.trim() ?? '';
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter an email address';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                  .hasMatch(val.trim())) {
                return 'Invalid email address';
              }
              return null;
            },
          ),
          CustomTextField(
            title: 'Password',
            obscure: true,
            onSaved: (val) {
              form['password'] = val ?? '';
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter password';
              }
              if (!RegExp(r"(?=.*\d)(?=.*[A-Z])(?=.*[a-z])((?=.*[^\w\d\s:])|(?=.*[_]))([^\s])*$")
                  .hasMatch(val)) {
                return 'Password does not meet requirements \nPassword must be at least eight characters \nPassword must have one letter \nPassword must have one number \nPassword must have one symbol';
              }
              return null;
            },
          ),
          CustomTextField(
            title: 'Confirm Password',
            obscure: true,
            onSaved: (val) {},
            validator: (val) {
              if (val != form['password']) return 'Passwords do not match';
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
                'Register',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                formKey.currentState!.save();
                if (formKey.currentState!.validate()) {
                  widget.callback(form);
                  formKey.currentState!.reset();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
