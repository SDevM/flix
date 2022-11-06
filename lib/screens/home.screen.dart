import 'package:flutter/material.dart';
import '../models/master.model.dart';

class Home extends StatefulWidget {
  final Master master;
  const Home({Key? key, required this.master}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/Logo_Flix.png'),
      ),
      body: Text(widget.master.userModel?.toJson()['name'] as String),
    );
  }
}
