import 'package:flutter/material.dart';
import '../widgets/upcoming_movies.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/carousel_popluar_Movies.dart';
import '../services/tmdb.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currectSlectedTab = 1;
  Map upcomingMovies = new Map();
  List upcomingMoviesList;
  Map popularMovies = new Map();
  List popularMovieList;
  Map nowPalyingMovies = new Map();
  List nowPalyingMoviesList;
  Map topRatedMovies = new Map();
  List topRatedMoviesList;
  var currentSlectedTab = 0;
  Map popularTvShows = new Map();
  List popularTvShowsList;

  @override
  void initState() {
    super.initState();
    fetchApi();
    updateMoviePopulaity(1);
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
      });
    }
  }

  updateMoviePopulaity(int currentTab) async {
    popularTvShowsList = popularTvShows["results"];

    popularMovies = await Tmdb.getPopularMovies();
    popularMovieList = popularMovies["results"];

    nowPalyingMovies = await Tmdb.getNowPlayingMovies();
    nowPalyingMoviesList = nowPalyingMovies["results"];

    topRatedMovies = await Tmdb.getTopRatedMovies();
    topRatedMoviesList = topRatedMovies["results"];

    if (popularMovieList == null &&
        nowPalyingMoviesList == null &&
        topRatedMoviesList == null) {
      setState(() {
        popularMovieList = [];
        nowPalyingMoviesList = [];
        topRatedMoviesList = [];
      });
    } else {
      setState(() {
        popularMovieList = popularMovies["results"];
        nowPalyingMoviesList = nowPalyingMovies["results"];
        topRatedMoviesList = topRatedMovies["results"];
      });
    }
    if (popularTvShowsList == null) {
      setState(() {});
    } else {
      setState(() {
        popularTvShowsList = popularTvShows["results"];
      });
    }
  }

  Widget moviePopularity(String itemName, int currentTab) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            itemName,
            style: TextStyle(
              fontSize: 23,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              'LoadSimilarMovies',
            );
          },
          child: Container(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 33.0,
            ),
          ),
        )
      ],
    );
  }

  Widget horizontalListview(movieCatagery) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, bottom: 15),
      alignment: Alignment.topLeft,
      child: moviePopularity(movieCatagery, 1),
    );
  }

  Widget bottomNavigationBar() {
    return ClipRRect(
      child: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Color.fromRGBO(25, 40, 60, 1),
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          //currentIndex: selectedTab,
          elevation: 20,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              currentSlectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: currentSlectedTab == 0 ? Colors.red : Colors.grey,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
                color: currentSlectedTab == 1 ? Colors.red : Colors.grey,
              ),
              title: Text('Bookmark'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                size: 30,
                color: currentSlectedTab == 2 ? Colors.red : Colors.grey,
              ),
              title: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        body: Center(
          child: Column(
            children: <Widget>[
              SearchBarWidget(),
              UpcomingMovies(upcomingMoviesList: upcomingMoviesList),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      horizontalListview("Popular"),
                      CarouselPopluarMovies(popularMovieList: popularMovieList),
                      horizontalListview("NowPlaying"),
                      CarouselPopluarMovies(
                          popularMovieList: nowPalyingMoviesList),
                      horizontalListview("TopRated"),
                      CarouselPopluarMovies(
                          popularMovieList: topRatedMoviesList),
                    ],
                  ),
                ),
              )
              // TvShows(popularTvShowsList: popularTvShowsList),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }
}
