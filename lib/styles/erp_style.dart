// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

class ERPStyle {
  static final ButtonStyle ERPsuccessElevatedButtonStyle =
      ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.green[300],
    minimumSize: const Size(88, 36),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static final ButtonStyle ERPstandartElevatedButtonStyle =
      ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.blue.shade700,
    minimumSize: const Size(88, 36),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static final ButtonStyle ERPcancelElevatedButtonStyle =
      ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.grey,
    minimumSize: const Size(88, 36),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
  static final ButtonStyle ERPcancelRedElevatedButtonStyle =
      ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.red.shade400,
    minimumSize: const Size(88, 36),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static final ButtonStyle ERPblueElevatedButtonStyle =
      ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.blue.shade400,
    minimumSize: const Size(88, 36),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static final ButtonStyle ERPappBarElevatedButtonStyle =
      ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.black54,
    minimumSize: const Size(88, 36),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static const ERPsplashColor = Colors.amber;

  static const ERPappBarBackGroundColor = Colors.black54;
  static final ERPtableCellContainerColor = Colors.grey.shade400;
  static const ERPappBarFontStyle = "";
  static const ERPListTileTextStyle = TextStyle(
    fontSize: 12.5,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 2,
  );
}
//2021©erp-mockup