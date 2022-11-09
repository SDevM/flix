import 'package:flix/utils/http.service.dart';
import 'package:flix/utils/text_styles.dart';
import 'package:flix/widgets/checkbox_column.widget.dart';
import 'package:flix/widgets/custom_file_field.widget.dart';
import 'package:flix/widgets/custom_number_field.dart';
import 'package:flix/widgets/custom_text_area.widget.dart';
import 'package:flix/widgets/custom_text_field.widget.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AddMovieForm extends StatefulWidget {
  final BoxConstraints box;
  final Function(Map<String, Object> form) callback;

  const AddMovieForm({Key? key, required this.box, required this.callback}) : super(key: key);

  @override
  State<AddMovieForm> createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Map<String, Object> form = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'images/bkg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.black.withOpacity(0.8),
          body: Form(
            key: formKey,
            child: ListView(
              cacheExtent: 2000,
              children: [
                Padding(padding: EdgeInsets.only(top: widget.box.maxHeight * 0.1)),
                Center(
                  child: Text(
                    'Add A Movie!',
                    style: titleStyle,
                  ),
                ),
                CustomTextField(
                  title: 'Title',
                  obscure: false,
                  onSaved: (val) {
                    if (val != null) form['title'] = val;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Invalid Title';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomNumberField(
                  title: 'Year',
                  obscure: false,
                  onSaved: (val) {
                    if (val != null) form['year'] = val;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty || int.parse(val) > DateTime.now().year) {
                      return 'Invalid Date';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextField(
                  title: 'Rating',
                  obscure: false,
                  onSaved: (val) {
                    if (val != null) form['rating'] = val;
                  },
                  validator: (val) {
                    if (RegExp(r'^(G)|(PG13)|(PG)|(R)|(NC17)$').hasMatch(val ?? '')) {
                      return null;
                    } else {
                      return 'Invalid Rating';
                    }
                  },
                ),
                CustomTextArea(
                    title: 'Description',
                    lines: 4,
                    onSaved: (val) {
                      if (val != null) form['description'] = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Invalid Description';
                      } else {
                        return null;
                      }
                    }),
                FutureBuilder<Map<String, dynamic>?>(
                    future: HTTP().get(Uri.parse('/categories')),
                    builder: (context, snap) {
                      if (snap.hasError) {
                        return Text('${snap.error}');
                      } else if (snap.hasData) {
                        var categories = snap.data!['data'] as List;
                        Map<String, String> set = {};
                        for (var element in categories) {
                          set[element['name'] as String] = element['_id'] as String;
                        }
                        return CheckBoxColumn(
                          set: set,
                          callback: (Map<String, bool> values) {
                            List<String> buffer = [];
                            for (var element in values.entries) {
                              if (element.value == true) buffer.add(element.key);
                            }
                            form['categories'] = buffer;
                          },
                          box: widget.box,
                        );
                      } else {
                        return const Text('No Response');
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomFileField(
                      title: 'Image',
                      extensions: const ['png', 'jpg', 'jpeg'],
                      onSaved: (file) {
                        if (file != null) form['image'] = file;
                      },
                      validator: (file) {
                        if (file == null || file.isEmpty) {
                          return 'No File Selected';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomFileField(
                        title: 'Clip',
                        extensions: const ['mp4'],
                        onSaved: (file) {
                          if (file != null) form['clip'] = file;
                        },
                        validator: (file) {
                          if (file == null || file.isEmpty) {
                            return 'No File Selected';
                          } else {
                            return null;
                          }
                        }),
                  ],
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
                      'Create',
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
          ),
        ),
      ],
    );
  }
}
