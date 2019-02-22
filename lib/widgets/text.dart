import 'package:flutter/material.dart';

Widget tileText({@required String title, Color color = Colors.black, double size = 18}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: "MavenPro",
      fontSize: size,
      color: color
    ),
  );
}

Widget tileSubItemText({@required String title, Color color = Colors.black}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: "MavenPro",
      fontSize: 15,
      color: color,
    ),
  );
}

Widget appBarTitle(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "MavenPro",
      fontSize: 26
    ),
  );
}

Widget dialogTitle({@required String title, Color color = Colors.blue}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: "MavenPro",
      fontSize: 18,
      color: color,
    ),
  );
}