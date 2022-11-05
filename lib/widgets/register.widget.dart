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
            title: 'Username',
            obscure: false,
            onSaved: (val) {},
            validator: (val) {},
          ),
          CustomTextField(
            title: 'Email',
            obscure: false,
            onSaved: (val) {},
            validator: (val) {},
          ),
          CustomTextField(
            title: 'Password',
            obscure: true,
            onSaved: (val) {},
            validator: (val) {},
          ),
          CustomTextField(
            title: 'Confirm Password',
            obscure: true,
            onSaved: (val) {},
            validator: (val) {},
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
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  widget.callback(form);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
