import 'package:flix/utils/colors.dart';
import 'package:flutter/material.dart';

class RoundedToggle extends StatefulWidget {
  final BoxConstraints box;
  final Function(bool toggle) callback;

  const RoundedToggle({Key? key, required this.box, required this.callback}) : super(key: key);

  @override
  State<RoundedToggle> createState() => _RoundedToggleState();
}

class _RoundedToggleState extends State<RoundedToggle> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          toggle = !toggle;
          widget.callback(toggle);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: paletteGreen,
        ),
        clipBehavior: Clip.antiAlias,
        width: widget.box.maxWidth * 0.7,
        height: 40,
        child: Stack(
          children: [
            AnimatedContainer(
              margin: !toggle
                  ? EdgeInsets.only(right: widget.box.maxWidth * 0.7 * 0.5)
                  : EdgeInsets.only(left: widget.box.maxWidth * 0.7 * 0.5),
              duration: const Duration(milliseconds: 300),
              width: widget.box.maxWidth * 0.7 * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: !toggle ? paletteYellow : Colors.white,
                          fontWeight: !toggle ? FontWeight.w800 : FontWeight.w500,
                        ),
                        child: const Text('Log In'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: toggle ? paletteYellow : Colors.white,
                          fontWeight: toggle ? FontWeight.w800 : FontWeight.w500,
                        ),
                        child: const Text('Register'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
