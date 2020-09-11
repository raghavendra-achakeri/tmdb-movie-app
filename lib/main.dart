import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import './screens/movie_full_details.dart';
import './widgets/load_similar_movies.dart';
import './screens/home_screen.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  print(Platform.isAndroid);
  if (Platform.isAndroid || Platform.isIOS) {
    runApp(MyApp());
  } else {
    runApp(
      DevicePreview(
        builder: (context) => MyApp(),
        enabled: !kReleaseMode,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        "MovieFullDetail": (context) => MovieFullDetail(),
        "LoadSimilarMovies": (context) => LoadSimilarMovies(),
      },
    );
  }
}
