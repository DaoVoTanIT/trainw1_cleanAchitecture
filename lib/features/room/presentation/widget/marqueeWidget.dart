import 'package:flutter/cupertino.dart';
import 'package:marquee/marquee.dart';

Widget marquee(String content) {
  return content.length > 10
      ? Marquee(
          text: content,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          scrollAxis: Axis.horizontal, //scroll direction
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 50.0, //speed
          pauseAfterRound: Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        )
      : Text(
          content,
          style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.5),
        );
}
