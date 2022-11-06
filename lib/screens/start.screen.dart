import 'package:flix/models/user.model.dart';
import 'package:flix/screens/home.screen.dart';
import 'package:flix/utils/colors.dart';
import 'package:flix/utils/text_styles.dart';
import 'package:flix/widgets/login.widget.dart';
import 'package:flix/widgets/register.widget.dart';
import 'package:flix/widgets/roundedToggle.widget.dart';
import 'package:flutter/material.dart';
import '../models/master.model.dart';

class Start extends StatefulWidget {
  final Master master;

  const Start({Key? key, required this.master}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final GlobalKey<RoundedToggleState> _toggleKey = GlobalKey<RoundedToggleState>();
  bool toggle = false;
  bool going = false;

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    return LayoutBuilder(builder: (ctx, box) {
      return Stack(
        children: [
          Image.asset(
            'images/bkg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                const Padding(padding: EdgeInsets.only(top: 175)),
                Center(
                  child: Image.asset(
                    'images/Logo_Flix.png',
                    width: box.maxWidth * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: RoundedToggle(
                    key: _toggleKey,
                    box: box,
                    callback: (bool toggle) async {
                      setState(() {
                        going = true;
                      });
                      await Future.delayed(const Duration(milliseconds: 300));
                      setState(() {
                        going = false;
                        this.toggle = toggle;
                      });
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50)),
                toggle
                    ? TweenAnimationBuilder(
                        tween: Tween<double>(begin: !going ? 0 : 1, end: !going ? 1 : 0),
                        duration: const Duration(milliseconds: 300),
                        builder: (ctx, value, child) {
                          return Opacity(
                            opacity: value,
                            child: RegForm(
                              box: box,
                              callback: (Map<String, Object> form) async {
                                showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.transparent,
                                        color: paletteYellow,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                  ),
                                );
                                await Future.delayed(const Duration(seconds: 1));
                                var response = await User.signUp(form).catchError((err) {
                                  nav.pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
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
                                                '$err',
                                                style: errorStyle,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                                if (response != null) {
                                  nav.pop();
                                  setState(() {
                                    toggle = false;
                                    _toggleKey.currentState?.toggle = toggle;
                                  });
                                }
                              },
                            ),
                          );
                        },
                      )
                    : TweenAnimationBuilder(
                        tween: Tween<double>(begin: !going ? 0 : 1, end: !going ? 1 : 0),
                        duration: const Duration(milliseconds: 300),
                        builder: (ctx, value, child) {
                          return Opacity(
                            opacity: value,
                            child: LoginForm(
                                box: box,
                                callback: (Map<String, Object> form) async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.transparent,
                                          color: paletteYellow,
                                          strokeWidth: 5,
                                        ),
                                      ),
                                    ),
                                  );
                                  await Future.delayed(const Duration(seconds: 1));
                                  User? user = await User.signIn(form).catchError((err) {
                                    nav.pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
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
                                                  '$err',
                                                  style: errorStyle,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                  if (user != null) {
                                    nav.pop();
                                    widget.master.userModel = user;
                                    nav.push(
                                      MaterialPageRoute(
                                        builder: (context) => Home(master: widget.master),
                                      ),
                                    );
                                  }
                                }),
                          );
                        },
                      )
              ],
            ),
          ),
        ],
      );
    });
  }
}
