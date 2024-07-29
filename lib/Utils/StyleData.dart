import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StyleData {
  static Color background = const Color(0xffffffff);
  static Color headingColor = const Color(0xff638fff);
  // static Color buttonColor = const Color(0xFFFD5A52);

  static Color backgroundDropdown = const Color(0xFFD7DCE0);
  static Color lableStyleColor = Colors.black;
  static Color cursorColor = Colors.black;
  static Color iconColor = Colors.lightBlueAccent;

  // // dark blue
  //
  // static Color appBarColor = const Color(0xff000044);
  // // dart green
  // static Color buttonColor = Color(0xff000044);

  static Color appBarColor = const Color(0xff750101);





  static DateFormat dateTimeFormat = DateFormat('dd/MM/yyyy hh:mm:ss');
  static DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  static DateFormat apiDateFormat = DateFormat('yyyy-MM-dd');

  static Color backgroundBlack = Colors.black;

  static String boldFont = "Poppins-Bold";
  static String regularFont = "Poppins-Regular";

  static OutlineInputBorder enableTextFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF837E93),
    ),
  );
  static OutlineInputBorder focusTextFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF837E93),
    ),
  );
}




