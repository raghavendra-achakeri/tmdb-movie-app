import 'package:flutter/material.dart';
import '../services/tmdb.dart';
import '../widgets/carousel_movie_trailer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/load_similar_movies.dart';

class MovieFullDetail extends StatefulWidget {
  MovieFullDetail({Key key}) : super(key: key);

  @override
  _MovieFullDetailState createState() => _MovieFullDetailState();
}

class _MovieFullDetailState extends State<MovieFullDetail> {
  var selectType = 1;
  Map eachMovie;
  String original_language;
  Map movieTrailers;
  Map similarMovies;
  List similarMoviesList;
  @override
  void initState() {
    super.initState();
    fetchSimilarMovies();
    Future.delayed(Duration.zero, () {
      setState(() {
        eachMovie = ModalRoute.of(context).settings.arguments as Map;
      });

      getMovieTrailer(eachMovie["id"]);
    });
  }

  fetchSimilarMovies() async {
    similarMovies = await Tmdb.getPopularMovies();
    similarMoviesList = similarMovies["results"];
    if (similarMoviesList == null) {
      setState(() {
        similarMoviesList = [];
      });
    } else {
      setState(() {
        similarMoviesList = similarMovies["results"];
      });
    }
  }

  Widget moviewDetailImage(Map eachMovieData) {
    if (eachMovieData["original_language"] == 'en') {
      original_language = "English";
    } else {
      original_language = "japanese";
    }
    return Container(
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                height: 300,
                fit: BoxFit.fill,
                imageUrl: "https://image.tmdb.org/t/p/w500" +
                        eachMovieData["backdrop_path"] ??
                    " ",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, "DetailedNewsPage");
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    eachMovieData["title"],
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 15.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        eachMovieData["release_date"]
                            .toString()
                            .substring(0, 4),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 15.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        original_language,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 15.0,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        eachMovieData["vote_count"].toString() + " Votes",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 0.5),
                      end: Alignment(0.0, 0.0),
                      colors: <Color>[
                        Color(0x60000000),
                        Color(0x00000000),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 0.7),
                end: Alignment(0.0, 0.0),
                colors: <Color>[
                  Color(0x60000000),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moviewDetailWatchButton(Map eachMovieData) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 45),
                color: Colors.red,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Watch Trailer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(35.0),
            child: Container(
              padding: EdgeInsets.all(8),
              color: Color.fromRGBO(30, 40, 50, 1),
              child: Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 35.0,
              ),
            ),
          ),
          ClipRRect(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.green),
                borderRadius: BorderRadius.all(
                    Radius.circular(40.0) //         <--- border radius here
                    ),
                color: Colors.black,
              ),
              padding: EdgeInsets.only(top: 13, left: 10),
              child: Text(
                eachMovieData["vote_average"].toString(),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moviewDetailDescription(Map eachMovieData) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        eachMovieData["overview"],
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }

  getMovieTrailer(int movieId) async {
    movieTrailers = await Tmdb.getMovieTrailers(movieId);
  }

  Widget clipsAndReviewsWidget(Map eachMovieData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              getMovieTrailer(eachMovieData["id"]);
              setState(() {
                selectType = 1;
              });
            },
            child: Text(
              "MoreTrailers",
              style: TextStyle(
                  fontSize: 25,
                  color: selectType == 1 ? Colors.red : Colors.grey),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              setState(() {
                selectType = 2;
              });
            },
            child: Text(
              "Reviews",
              style: TextStyle(
                  fontSize: 25,
                  color: selectType == 2 ? Colors.red : Colors.grey),
            ),
          ),
        )
      ],
    );
  }

  Widget similarMovieHeading() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "similar Movies",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'LoadSimilarMovies',
                );
              },
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 35.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    eachMovie = ModalRoute.of(context).settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        body: Center(
          child: Column(
            children: [
              moviewDetailImage(eachMovie),
              moviewDetailWatchButton(eachMovie),
              moviewDetailDescription(eachMovie),
              clipsAndReviewsWidget(eachMovie),
              MovieTrailers(eachMovieData: eachMovie),
              similarMovieHeading(),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child:
              //         LoadSimilarMovies(similarMoviesList: similarMoviesList),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
