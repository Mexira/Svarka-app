import 'dart:math';

class AppBackground {
  static final List<String> backgrounds = [
    'assets/fon1.jpg',
    'assets/fon2.jpg',
    'assets/fon3.jpg',
    'assets/fon4.jpg',
    'assets/svarshik.jpg',
    'assets/svarshik2.jpg',
  ];

  static String currentBackground =
  backgrounds[Random().nextInt(backgrounds.length)];

  static void changeRandom() {
    currentBackground =
    backgrounds[Random().nextInt(backgrounds.length)];
  }
}