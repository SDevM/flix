import 'package:flix/models/movie.model.dart';
import 'package:flix/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../environment.dart';
import '../models/master.model.dart';
import '../screens/home.screen.dart';

class Profile extends StatefulWidget {
  final Master master;
  final BoxConstraints box;
  final Function(HomePage page) callback;

  const Profile({Key? key, required this.box, required this.master, required this.callback})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var user = widget.master.userModel!.toJson();
    return Column(
      children: [
        Text('${user['name']}', style: titleStyle),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Favorites'),
            TextButton(onPressed: () {
              widget.callback(HomePage.catalogue);
            }, child: const Text('Back'))
          ],
        ),
        Expanded(
          child: GridView.builder(
            itemCount: (user['favorites'] as List).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 10 / 16,
            ),
            itemBuilder: (context, step) => FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, pref) {
                  if (pref.connectionState == ConnectionState.done) {
                    return FutureBuilder(
                        future: Movie.get('${(user['favorites'] as List)[step]}'),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.done) {
                            return Image.network(
                              '$apiUrl/s3/${snap.data!['data']['image']}',
                              headers: {
                                'Authorization': pref.data!.getString('jwt_auth') ?? '',
                              },
                              isAntiAlias: true,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          } else {
                            return Image.asset('images/placeholder.jpg');
                          }
                        });
                  } else {
                    return Image.asset('images/placeholder.jpg');
                  }
                }),
          ),
        )
      ],
    );
  }
}
