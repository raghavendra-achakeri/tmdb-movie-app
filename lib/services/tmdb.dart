import 'package:tmdb_api/tmdb_api.dart';

class Tmdb {
  static TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys('d4bdb9c25c982a5472c78dac1ced3390', ''),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  static getPopularMovies() async {
    return await tmdbWithCustomLogs.v3.movies.getPouplar();
  }

  static getUpcomingMovies() async {
    return tmdbWithCustomLogs.v3.movies.getUpcoming();
  }

  static getNowPlayingMovies() async {
    return tmdbWithCustomLogs.v3.movies.getNowPlaying();
  }

  static getTopRatedMovies() async {
    return tmdbWithCustomLogs.v3.movies.getTopRated();
  }

  static getPopularTVShows() async {
    return tmdbWithCustomLogs.v3.tv.getAiringToday();
  }

  static getMovieTrailers(int id) async {
    return tmdbWithCustomLogs.v3.movies.getVideos(id);
  }
}
