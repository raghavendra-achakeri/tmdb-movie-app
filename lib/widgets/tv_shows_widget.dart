import 'package:flutter/material.dart';

import '../widgets/shimmer_effect_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TvShows extends StatefulWidget {
  final List popularTvShowsList;
  TvShows({Key key, this.popularTvShowsList}) : super(key: key);

  @override
  _TvShowsState createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  List eachTvShows;

  Widget fetchTVShowFeed(index) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 8,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                width: 260,
                height: 180,
                fit: BoxFit.fill,
                imageUrl: "https://image.tmdb.org/t/p/w500" +
                        eachTvShows[index]["backdrop_path"] ??
                    " ",
              ),
            ),
          ),
          Container(
            width: 270,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              eachTvShows[index]["name"],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 5, left: 20, top: 5),
                child: Icon(
                  Icons.grade,
                  color: Colors.yellow,
                  size: 19.0,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 7),
                child: Text(
                  "${eachTvShows[index]["vote_average"].toString()}/10",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget carouselUpcomingTVShows() {
    if (widget.popularTvShowsList == null) {
      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder: (context, index) {
            return ShimmerEffect.LoadShimmerEffect(index);
          });
    } else {
      setState(() {
        eachTvShows = widget.popularTvShowsList;
      });

      return Flexible(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: eachTvShows.length,
            itemBuilder: (context, index) {
              return fetchTVShowFeed(index);
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, bottom: 15),
              child: Text(
                "Popular TV Shows",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              child: carouselUpcomingTVShows(),
            ),
          ],
        ),
      ),
    );
  }
}
