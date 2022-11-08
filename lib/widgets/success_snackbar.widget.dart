import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class SuccessSnackBar extends SnackBar {
  final String msg;

  SuccessSnackBar({Key? key, required this.msg})
      : super(
    key: key,
    padding: const EdgeInsets.all(20),
    backgroundColor: Colors.transparent,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              msg,
              style: successStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}