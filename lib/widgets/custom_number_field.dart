import 'package:flix/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomNumberField extends StatelessWidget {
  final String title;
  final bool obscure;
  final void Function(String? val) onSaved;
  final String? Function(String? val) validator;

  const CustomNumberField({
    Key? key,
    required this.title,
    required this.obscure,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: obscure,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: paletteGreen,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          floatingLabelStyle: TextStyle(
            color: paletteGreen,
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          labelText: title,
        ),
      ),
    );
  }
}