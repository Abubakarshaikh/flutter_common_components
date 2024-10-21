import 'package:flutter/material.dart';

// box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
class ShadowUtils {
  static final List<BoxShadow> transparentShadow = <BoxShadow>[
    const BoxShadow(
      color: Color.fromRGBO(255, 255, 255, 0.2),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static final List<BoxShadow> softShadow = <BoxShadow>[
    const BoxShadow(
      color: Color.fromRGBO(100, 100, 111, 0.2),
      offset: Offset(20, 7),
      blurRadius: 50,
    ),
  ];
}
