import 'package:flutter/material.dart';
import '../services/api_sevice.dart';
import '../widgets/shimmer_effect_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/play_trailer.dart';
import '../services/tmdb.dart';

class MovieTrailers extends StatefulWidget {
  final Map eachMovieData;
  MovieTrailers({Key key, this.eachMovieData}) : super(key: key);

  @override
  _MovieTrailersState createState() => _MovieTrailersState();
}

class _MovieTrailersState extends State<MovieTrailers> {
  List eachMovie;

  @override
  void initState() {
    super.initState();
    loadtrailerApi();
  }

  loadtrailerApi() async {
    Map trailer = await Tmdb.getMovieTrailers(widget.eachMovieData["id"]);
    print(trailer);
  }

  Widget fetchMovieTrailer(index) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      PlayTrailer(movieId: widget.eachMovieData["id"]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        width: 200,
                        height: 130,
                        fit: BoxFit.fill,
                        imageUrl: eachMovie[index] ?? " ",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: 10, right: 15),
              child: Text(
                "2:30",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: 100,
                    child: Text(
                      "trailer ${index + 1} Cropoman",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget carouselMovieTrailer() {
    if (ApiService.imgList == null) {
      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder: (context, index) {
            return ShimmerEffect.LoadShimmerEffect(index);
          });
    } else {
      eachMovie = ApiService.imgList;

      return Container(
        height: 150,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: eachMovie.length,
            itemBuilder: (context, index) {
              return fetchMovieTrailer(index);
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: carouselMovieTrailer(),
    );
  }
}
