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

  static recorderContainer({start = 0xFFFF5A5F, end = 0xFFFF5A5F}){
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(start), Color(end)]
        )
      );
  }

  static leftMessageContainer({start = 0xFF394247, end = 0xFF20272D}){
    return BoxDecoration(
      borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(start), Color(end)]
        )
      );
  }

  static rightMessageContainer({start = 0xFF394247, end = 0xFF20272D}){
    return BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(start), Color(end)]
        )
      );
  }
}
