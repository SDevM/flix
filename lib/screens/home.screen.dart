import 'package:flix/models/movie.model.dart';
import 'package:flix/pages/catalogue.page.dart';
import 'package:flix/pages/details.page.dart';
import 'package:flix/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/master.model.dart';
import '../widgets/error_snackbar.widget.dart';
import '../widgets/success_snackbar.widget.dart';
import 'add_movie.screen.dart';

class Home extends StatefulWidget {
  final Master master;

  const Home({Key? key, required this.master}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomePage page = HomePage.catalogue;

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    var messenger = ScaffoldMessenger.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: LayoutBuilder(builder: (context, box) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Image.asset('images/Logo_Flix.png'),
            leadingWidth: box.maxWidth * 0.15,
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  size: 35,
                  color: paletteGreen,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () async {
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
                  var response = await widget.master.userModel!.logOut().catchError((err) {
                    nav.pop();
                    messenger.showSnackBar(
                      ErrorSnackBar(err: '$err'),
                    );
                  });
                  if (response != null) {
                    nav.pop();
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }
                },
                icon: Icon(
                  Icons.logout,
                  size: 30,
                  color: paletteYellow,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: paletteGreen,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddMovieForm(
                    box: box,
                    callback: (form) async {
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
                      var response = await Movie.save(form).catchError((err) {
                        nav.pop();
                        messenger.showSnackBar(
                          ErrorSnackBar(err: '$err'),
                        );
                      });
                      if (response != null) {
                        nav.pop();
                        nav.pop();
                        messenger.showSnackBar(
                          SuccessSnackBar(msg: 'Movie Made Successfully'),
                        );
                      }
                    },
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          body: Builder(
            builder: (context) {
              switch (page) {
                case HomePage.catalogue:
                  return Catalogue(
                    box: box,
                    master: widget.master,
                    callback: (page) {
                      setState(() {
                        this.page = page;
                      });
                    },
                  );
                case HomePage.details:
                  return Details(
                    master: widget.master,
                    box: box,
                    callback: (page) {
                      setState(() {
                        this.page = page;
                      });
                    },
                  );
              }
            },
          ),
        );
      }),
    );
  }
}

enum HomePage { catalogue, details }
