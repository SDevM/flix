import 'package:flix/models/movie.model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String search;

  const SearchScreen({Key? key, required this.search}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = '';

  @override
  void initState() {
    super.initState();
    search = widget.search;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Movie.search(search, 10),
      builder: (context, snap) => Container(),
    );
  }
}
