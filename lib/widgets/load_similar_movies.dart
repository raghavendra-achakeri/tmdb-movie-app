import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../services/tmdb.dart';
import 'package:shimmer/shimmer.dart';

class LoadSimilarMovies extends StatefulWidget {
  final List similarMoviesList;

  LoadSimilarMovies({Key key, this.similarMoviesList}) : super(key: key);

  @override
  _LoadSimilarMoviesState createState() => _LoadSimilarMoviesState();
}

class _LoadSimilarMoviesState extends State<LoadSimilarMovies> {
  Map upcomingMovies = new Map();
  List upcomingMoviesList;
  int movieLength;
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  fetchApi() async {
    upcomingMovies = await Tmdb.getUpcomingMovies();
    upcomingMoviesList = upcomingMovies["results"];
    if (upcomingMoviesList == null) {
      setState(() {
        upcomingMoviesList = [];
      });
    } else {
      setState(() {
        upcomingMoviesList = upcomingMovies["results"];
        movieLength = upcomingMoviesList.length;
      });
    }
    // print(upcomingMoviesList[0]["poster_path"]);
  }

  Widget loadShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.4),
      highlightColor: Colors.black.withOpacity(0.15),
      period: Duration(milliseconds: 600),
      child:
          //  padding: EdgeInsets.only(top: 10),

          Container(
        width: 150,
        height: 180,
        padding: EdgeInsets.all(7.0),
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }

  Widget moviesRunder() {
    if (upcomingMoviesList == null) {
      return Container(
        color: Colors.grey,
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(20, (index) {
            return Center(
              child: loadShimmerEffect(),
            );
          }),
        ),
      );
    } else {
      return GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(movieLength, (index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'MovieFullDetail',
                  arguments: upcomingMoviesList[index],
                );
              },
              child: ClipRRect(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: "https://image.tmdb.org/t/p/w500" +
                          upcomingMoviesList[index]["poster_path"] ??
                      " ",
                ),
              ),
            ),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        body: Center(
            child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, "LoadSimilarMovies");
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 20),
                    child: Text(
                      "Simiar Movies",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: moviesRunder(),
            )
          ],
        )),
      ),
    );
  }
}
