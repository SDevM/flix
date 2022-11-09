import 'package:flix/models/master.model.dart';
import 'package:flix/models/user.model.dart';
import 'package:flix/screens/home.screen.dart';
import 'package:flix/screens/start.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Master master = Master();
    return MaterialApp(
      title: 'Flix',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white),
      ),
      home: FutureBuilder(
        future: User.session(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.hasError) {
              return Start(master: master);
            } else if (snap.hasData) {
              master.userModel = snap.data!;
              return Home(master: master);
            }
            throw 'No Data';
          } else {
            return Center(
              child: Image.asset('images/Logo_Flix.png'),
            );
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
