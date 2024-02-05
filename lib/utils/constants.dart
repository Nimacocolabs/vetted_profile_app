import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static final rupeeSymbol = "\u20B9";
  static List<Color> themeGradients = [
    Color(0xff03273c),
    Color.fromRGBO(255, 255, 255, 1.0),
  ];

  static TextStyle boldHeading =
  TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle boldWord =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle boldValue =
  TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle lightWord = TextStyle(fontSize: 20);
  static SizedBox thickSpace = SizedBox(
    height: 10,
  );
  static final DateTime now = DateTime.now();
  static final DateFormat formatterDate = DateFormat('dd-MM-yyyy');
  static final DateFormat yMD = DateFormat('yyyy-MM-dd');
  static final DateFormat formatterDateTime = DateFormat('dd-MM-yyyy hh:mm:ss');
  static final DateFormat formatterDateTime12 = DateFormat.yMd().add_jm();
  static final DateFormat formatterTime12 = DateFormat.jm();
  static String dateToday = formatterDate.format(now);
  static const IconData filter = IconData(0xe26f, fontFamily: 'MaterialIcons');
}
