import 'package:flutter/cupertino.dart';

class IconGradientPresets{

  static const LinearGradient tech = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors:[
        Color.fromRGBO(32, 176, 250, 1),
        Color.fromRGBO(0, 95, 252, 1),
      ]
  );

  static const LinearGradient passion = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color.fromRGBO(248, 177, 43, 1),
        Color.fromRGBO(254, 86, 136, 1),
      ]
  );

  static const LinearGradient cool = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color.fromRGBO(114, 131, 253, 1),
        Color.fromRGBO(200, 56, 250, 1),
      ]
  );

  static const LinearGradient nature = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(5, 194, 84, 1),
        Color.fromRGBO(138, 246, 97, 1),
      ]
  );

  static final List<LinearGradient> all = [
    tech,
    passion,
    cool,
    nature
  ];
}

class CardGradientPresets{
  static const LinearGradient sky = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(36,141,254, 1),
        Color.fromRGBO(6,101,255, 1),
      ]
  );
}