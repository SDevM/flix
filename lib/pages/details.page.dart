import 'package:chewie/chewie.dart';
import 'package:flix/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../environment.dart';
import '../models/master.model.dart';
import '../screens/home.screen.dart';
import '../utils/colors.dart';
import '../widgets/error_snackbar.widget.dart';
import '../widgets/success_snackbar.widget.dart';

class Details extends StatefulWidget {
  final Master master;
  final BoxConstraints box;
  final Function(HomePage page) callback;

  const Details({Key? key, required this.box, required this.master, required this.callback})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  VideoPlayerController _video = VideoPlayerController.network('');
  Map<String, Object>? _movie;
  Map<String, Object>? _user;
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    _movie = widget.master.movieModel!.toJson();
    _user = widget.master.userModel!.toJson();
    int indexOf = (_user!['favorites'] as List<String>).indexOf(_movie!['_id'] as String);
    if (indexOf > -1) favorite = true;
    _video = VideoPlayerController.network(
      '$apiUrl/s3/${_movie!['clip']}',
    );
    _video.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _video.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    var messenger = ScaffoldMessenger.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: widget.box.maxWidth,
            height: widget.box.maxWidth * 0.5,
            child: Chewie(
              controller: ChewieController(
                videoPlayerController: _video,
                allowFullScreen: false,
              ),
            ),
          ),
          Text(
            '${_movie?['title']}',
            style: titleStyle,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 20, 20),
                child: Text('${_movie?['year']}'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 20, 20),
                child: Text('${_movie?['rating']}'),
              ),
            ],
          ),
          Text(
            '${_movie?['description']}',
            style: bodyStyle,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Stack(
                children: [
                  Image.network(
                    '$apiUrl/s3/${_movie?['image']}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic>? response;
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
                      if (favorite) {
                        favorite = false;
                        (_user?['favorites'] as List<String>).remove(_movie!['_id'] as String);
                      } else {
                        favorite = true;
                        (_user?['favorites'] as List<String>).add(_movie!['_id'] as String);
                      }
                      widget.master.userModel!.from(_user!);
                      response = await widget.master.userModel!.update().catchError((err) {
                        nav.pop();
                        messenger.showSnackBar(ErrorSnackBar(err: '$err'));
                      });
                      if (response != null) {
                        nav.pop();
                        messenger.showSnackBar(SuccessSnackBar(msg: 'Favorites Updated'));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white.withOpacity(0.5),
                      child: Icon(
                        Icons.star,
                        size: 100,
                        color: !favorite ? Colors.blueGrey : Colors.yellowAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.callback(HomePage.catalogue);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: paletteYellow,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Back to Catalogue'),
          )
        ],
      ),
    );
  }
}
