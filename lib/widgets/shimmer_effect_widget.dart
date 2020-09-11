import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect {
  static LoadShimmerEffect(var index) {
    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.4),
      highlightColor: Colors.black.withOpacity(0.15),
      period: Duration(milliseconds: 600),
      child: Container(
        //  padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 120,
              height: 150,
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.only(bottom: 10, left: 12),
              color: Colors.black.withOpacity(0.2),
            ),
            Container(
              width: 120,
              height: 150,
              padding: EdgeInsets.all(7.0),
              margin: EdgeInsets.only(bottom: 10, left: 12),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
