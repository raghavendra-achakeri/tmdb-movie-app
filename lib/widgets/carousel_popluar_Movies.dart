import 'package:flutter/material.dart';
import '../widgets/shimmer_effect_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselPopluarMovies extends StatefulWidget {
  final List popularMovieList;
  CarouselPopluarMovies({Key key, this.popularMovieList}) : super(key: key);

  @override
  _CarouselPopluarMoviesState createState() => _CarouselPopluarMoviesState();
}

class _CarouselPopluarMoviesState extends State<CarouselPopluarMovies> {
  Map moviePopular = new Map();

  List eachMovie;

  @override
  void initState() {
    super.initState();
  }

  Widget fetchMovieFeed(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'MovieFullDetail',
                  arguments: eachMovie[index],
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  width: 120,
                  height: 140,
                  fit: BoxFit.fill,
                  imageUrl: "https://image.tmdb.org/t/p/w500" +
                          eachMovie[index]["poster_path"] ??
                      " ",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget carouselPopularMovie() {
    if (widget.popularMovieList == null) {
      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder: (context, index) {
            return ShimmerEffect.LoadShimmerEffect(index);
          });
    } else {
      eachMovie = widget.popularMovieList;

      return Container(
        height: 180,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: eachMovie.length,
            itemBuilder: (context, index) {
              return fetchMovieFeed(index);
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: carouselPopularMovie(),
    );
  }
}
