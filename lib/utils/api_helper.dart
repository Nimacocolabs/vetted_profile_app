import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// String sampleImageUrl =
//     'https://d1pnnwteuly8z3.cloudfront.net/images/7462b53b-722a-4118-bce0-9de00cb86bc3/042e4872-744c-41b8-b577-5e4cf43d584d.jpeg';


MaterialColor primaryColor = MaterialColor(int.parse("0xff191970"),

    {
   50: Color(0xff1434A4),
  100: Color(0xff7485db),
  200: Color(0xff6071c7),
  300: Color(0xff6482c5),
  400: Color(0xff0e66e7),
 }
);
 MaterialColor secondaryColor = MaterialColor(int.parse("0xff96DED1"), {});
//   50: Color(0xffffffff),
//   100: Color(0xffffffff),
//   200: Color(0xffffffff),
//   300: Color(0xffffffff),
//   400: Color(0xffffffff),
//   500: Color(0xffffffff),
//   600: Color(0xffffffff),
//   700: Color(0xffffffff),
//   800: Color(0xffffffff),
//   900: Color(0xffffffff),
// });

Color secondaryColorShade = Color(0xff001043);

double screenWidth = 0.0;
double screenHeight = 0.0;

String rupeeSymbol = '₹';

void setScreenDimensions(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
}

void toastMessage(dynamic message,
    {ToastGravity gravity = ToastGravity.BOTTOM}) {
  log('toast: $message');
  Fluttertoast.showToast(msg: '$message', gravity: gravity);
}

String parseformatDate(var _dt, [String? _format]) {
  var dateformat = new DateFormat(_format);
  DateFormat apidatedateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  try {
    return dateformat.format(apidatedateFormat.parse(_dt));

    // DateFormat(_format).format(DateTime.parse(_dt));
  } catch (e) {
    try {
      return DateFormat(_format).format(DateTime.parse(_dt));
    } catch (e2) {
      return '<ErrDate>';
    }
  }
}

String getDateGap(String dateReceived) {
  try {
    DateTime dateTimeCreatedAt = DateTime.parse(dateReceived);
    DateTime dateTimeNow = DateTime.now();
    final differenceInDays = dateTimeCreatedAt.difference(dateTimeNow).inDays;
    print('$differenceInDays');
    return '$differenceInDays';
  } catch (e) {
    return "";
  }
}


double getFileSizeInMb(File file)  {
  int sizeInBytes = file.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);

  print('${file.path}: $sizeInMb');
  return sizeInMb;
}


extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
