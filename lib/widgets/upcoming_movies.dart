import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../services/api_sevice.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UpcomingMovies extends StatefulWidget {
  final List upcomingMoviesList;
  UpcomingMovies({Key key, this.upcomingMoviesList}) : super(key: key);

  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  @override
  void initState() {
    super.initState();
  }

  loadCarouselSlider() {
    if (widget.upcomingMoviesList == null) {
      return CarouselSlider(
        options: CarouselOptions(height: 185.0),
        items: ApiService.imgList.map((index) {
          return Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
                    width: 310,
                    child: Image.network(
                      index,
                      height: 180,
                      fit: BoxFit.fitWidth,
                      width: 180,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      "Avengers ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(height: 185.0),
        items: List<Widget>.from(
          widget.upcomingMoviesList.map((listData) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'MovieFullDetail',
                      arguments: listData,
                    );
                  },
                  child: Container(
                    width: 310,
                    child: Stack(
                      children: [
                        Container(
                          constraints: BoxConstraints.expand(),
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                              width: 150,
                              height: 180,
                              fit: BoxFit.fill,
                              imageUrl: "https://image.tmdb.org/t/p/w500" +
                                      listData["backdrop_path"] ??
                                  " ",
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 7,
                          height: 40,
                          child: Container(
                            width: 300,
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 20, bottom: 10),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                spreadRadius: 3,
                                color: Colors.black26,
                                blurRadius: 20.0,
                              ),
                            ]),
                            child: Text(
                              listData['original_title'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: loadCarouselSlider(),
    );
  }
}
