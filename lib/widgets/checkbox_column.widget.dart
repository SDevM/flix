import 'package:flix/utils/colors.dart';
import 'package:flix/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CheckBoxColumn extends StatefulWidget {
  final Map<String, String> set;
  final void Function(Map<String, bool> values) callback;
  final BoxConstraints box;

  const CheckBoxColumn({Key? key, required this.set, required this.callback, required this.box})
      : super(key: key);

  @override
  State<CheckBoxColumn> createState() => _CheckBoxColumnState();
}

class _CheckBoxColumnState extends State<CheckBoxColumn> {
  Map<String, bool> values = {};

  @override
  void initState() {
    super.initState();
    for (var element in widget.set.entries) {
      values[element.value] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: paletteGreen, toggleableActiveColor: paletteYellow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.set.entries
            .map(
              (e) => CheckboxListTile(
                checkColor: Colors.white,
                onChanged: (val) {
                  setState(() {
                    values[e.value] = !values[e.value]!;
                    widget.callback(values);
                  });
                },
                value: values[e.value],
                title: Text(e.key, style: bodyStyle,),
              ),
            )
            .toList(),
      ),
    );
  }
}
