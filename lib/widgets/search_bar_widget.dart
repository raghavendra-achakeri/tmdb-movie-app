import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({Key key}) : super(key: key);
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  int selectCategory = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {},
              child: Text(
                "MF",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectCategory = 1;
                });
              },
              child: Text(
                "Movies",
                style: TextStyle(
                    fontSize: 20,
                    color: selectCategory == 1 ? Colors.red : Colors.grey),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                setState(() {
                  selectCategory = 2;
                });
              },
              child: Text(
                "TVShows",
                style: TextStyle(
                    fontSize: 20,
                    color: selectCategory == 2 ? Colors.red : Colors.grey),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
