import 'package:flutter/painting.dart';

abstract final class AppShadows {
  static const List<BoxShadow> transparent = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(255, 255, 255, 0.2),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static const List<BoxShadow> soft = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(100, 100, 111, 0.2),
      offset: Offset(20, 7),
      blurRadius: 50,
    ),
  ];
}
