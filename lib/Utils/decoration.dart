import 'package:flutter/material.dart';

class Decorations {

  static background({start = 0xFF394247, end = 0xFF20272D}) {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(start), Color(end)]
        )
      );
  }

  static roundedContainer({start = 0xFF394247, end = 0xFF20272D}){
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(start), Color(end)]
        )
      );
  }
}
