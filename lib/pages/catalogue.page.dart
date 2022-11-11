import 'package:flix/screens/home.screen.dart';
import 'package:flix/screens/search.screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../environment.dart';
import '../models/master.model.dart';
import '../models/movie.model.dart';
import '../utils/colors.dart';
import '../utils/httpTools.dart';
import '../utils/text_styles.dart';

class Catalogue extends StatefulWidget {
  final Master master;
  final BoxConstraints box;
  final Function(HomePage page) callback;

  const Catalogue({Key? key, required this.box, required this.master, required this.callback})
      : super(key: key);

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  String searchval = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Text(
            'Hi, ${widget.master.userModel?.toJson()['name']}!',
            style: titleStyle,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Center(
          child: Container(
            width: widget.box.maxWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SearchScreen(search: searchval);
                    }));
                  },
                  icon: const Icon(Icons.search),
                  color: paletteYellow,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      searchval = val;
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: paletteGreen,
                            width: 2,
                          ),
                        ),
                        hintText: 'Search Movies...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Center(
          child: SizedBox(
            width: widget.box.maxWidth * 0.8,
            height: widget.box.maxHeight * 0.8,
            child: FutureBuilder<Map<String, dynamic>?>(
              future: Movie.getMany(PagedFiltered(page: 1, limit: 20)),
              builder: (context, movieGet) {
                if (movieGet.hasError) {
                  return const Text('Future Failed');
                } else if (movieGet.data == null) {
                  return const Text('No Response');
                } else if (movieGet.data!['data'] != null) {
                  widget.master.movieCatalogue = [];
                  for (var movie in (movieGet.data!['data'] as List<dynamic>)) {
                    widget.master.movieCatalogue.add(Movie.fromJson(movie as Map<String, dynamic>));
                  }
                  return GridView.builder(
                    itemCount: widget.master.movieCatalogue.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 10 / 16,
                    ),
                    itemBuilder: (context, step) => GestureDetector(
                      onTap: () {
                        widget.master.movieModel = widget.master.movieCatalogue[step];
                        widget.callback(HomePage.details);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: FutureBuilder(
                                  future: SharedPreferences.getInstance(),
                                  builder: (context, snap) {
                                    if (snap.connectionState == ConnectionState.done) {
                                      return Image.network(
                                        '$apiUrl/s3/${widget.master.movieCatalogue[step].toJson()['image']}',
                                        headers: {
                                          'Authorization': snap.data!.getString('jwt_auth') ?? '',
                                        },
                                        isAntiAlias: true,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    } else {
                                      return Image.asset('images/placeholder.jpg');
                                    }
                                  }),
                            ),
                          ),
                          Text('${widget.master.movieCatalogue[step].toJson()['title']}')
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text('No Movies');
                }
                // return GridView(
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                // );
              },
            ),
          ),
        ),
      ],
    );
  }
}
