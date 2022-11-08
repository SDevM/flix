import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

class ErrorSnackBar extends SnackBar {
  final String err;

  ErrorSnackBar({Key? key, required this.err})
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
                    err,
                    style: errorStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
}
