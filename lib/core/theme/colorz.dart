import 'package:flutter/material.dart';

abstract class Colorz {
  // --------------------
  static const Color majorelleBlue        = Color.fromARGB(255, 93, 66, 242); // #5d42f2
  static const Color majorelleBlueDark1   = Color.fromARGB(255, 79, 58, 216); // #4f3ad8
  static const Color majorelleBlueDark2   = Color.fromARGB(255, 66, 47, 190); // #422fbe
  static const Color majorelleBlueDark3   = Color.fromARGB(255, 53, 36, 164); // #3524a4
  static const Color majorelleBlueDark4   = Color.fromARGB(255, 38, 24, 130); // #261882
  static const Color majorelleBlueDark5   = Color.fromARGB(255, 23, 13, 88);  // #170d58
  // --------------------
  static const Color lightSeaGreen        = Color.fromARGB(255, 0, 184, 175); // #00b8af
  static const Color lightSeaGreenDark1   = Color.fromARGB(255, 0, 157, 150); // #009d96
  static const Color lightSeaGreenDark2   = Color.fromARGB(255, 0, 131, 125); // #00837d
  static const Color lightSeaGreenDark3   = Color.fromARGB(255, 0, 105, 100); // #006964
  static const Color lightSeaGreenDark4   = Color.fromARGB(255, 0, 79, 75);   // #004f4b
  static const Color lightSeaGreenDark5   = Color.fromARGB(255, 0, 52, 50);   // #003432
  // --------------------
  static const Color blue        = Color.fromARGB(255, 0, 25, 247); // #0019f7
  static const Color blueDark1   = Color.fromARGB(255, 0, 21, 210); // #0015d2
  static const Color blueDark2   = Color.fromARGB(255, 0, 17, 175); // #0011af
  static const Color blueDark3   = Color.fromARGB(255, 0, 14, 140); // #000e8c
  static const Color blueDark4   = Color.fromARGB(255, 0, 10, 105); // #000a69
  static const Color blueDark5   = Color.fromARGB(255, 0, 7, 70);   // #000746
  // --------------------
  /// Black & White
  static const Color black = Color.fromARGB(255, 0, 0, 0);       // #000000
  static const Color white = Color.fromARGB(255, 255, 255, 255); // #ffffff
  // --------------------
  /// Greys
  static const Color greyLightest = Color.fromARGB(255, 219, 219, 219); // #dbdbdb
  static const Color greyLight    = Color.fromARGB(255, 164, 164, 164); // #a4a4a4
  static const Color greyDark     = Color.fromARGB(255, 109, 109, 109); // #6d6d6d
  static const Color greyDarkest  = Color.fromARGB(255, 36, 36, 36);    // #242424
  // --------------------
  static const Color nothing = Color.fromARGB(0, 255, 255, 255);
  // --------------------
  static const int _blackR = 0;
  static const int _blackG = 0;
  static const int _blackB = 0;
  static const Color black0 = Color.fromARGB(0, _blackR, _blackG, _blackB);
  static const Color black10 = Color.fromARGB(10, _blackR, _blackG, _blackB);
  static const Color black20 = Color.fromARGB(20, _blackR, _blackG, _blackB);
  static const Color black30 = Color.fromARGB(30, _blackR, _blackG, _blackB);
  static const Color black50 = Color.fromARGB(50, _blackR, _blackG, _blackB);
  static const Color black80 = Color.fromARGB(80, _blackR, _blackG, _blackB);
  static const Color black125 = Color.fromARGB(125, _blackR, _blackG, _blackB);
  static const Color black150 = Color.fromARGB(150, _blackR, _blackG, _blackB);
  static const Color black200 = Color.fromARGB(200, _blackR, _blackG, _blackB);
  static const Color black230 = Color.fromARGB(230, _blackR, _blackG, _blackB);
  static const Color black255 = Color.fromARGB(255, _blackR, _blackG, _blackB);
  // --------------------
  static const int _whiteR = 255;
  static const int _whiteG = 255;
  static const int _whiteB = 255;
  static const Color white10 = Color.fromARGB(10, _whiteR, _whiteG, _whiteB);
  static const Color white20 = Color.fromARGB(20, _whiteR, _whiteG, _whiteB);
  static const Color white30 = Color.fromARGB(30, _whiteR, _whiteG, _whiteB);
  static const Color white50 = Color.fromARGB(50, _whiteR, _whiteG, _whiteB);
  static const Color white80 = Color.fromARGB(80, _whiteR, _whiteG, _whiteB);
  static const Color white125 = Color.fromARGB(125, _whiteR, _whiteG, _whiteB);
  static const Color white200 = Color.fromARGB(200, _whiteR, _whiteG, _whiteB);
  static const Color white230 = Color.fromARGB(230, _whiteR, _whiteG, _whiteB);
  static const Color white255 = Color.fromARGB(255, _whiteR, _whiteG, _whiteB);
  // --------------------
  static const Color facebook = Color.fromARGB(255, 59, 89, 152);
  static const Color linkedIn = Color.fromARGB(255, 0, 115, 176);
  static const Color googleRed = Color.fromARGB(255, 234, 67, 53);
  static const Color youtube = Color.fromRGBO(255, 0, 0, 1);
  static const Color instagram = Color.fromRGBO(193, 53, 132, 1);
  static const Color pinterest = Color.fromRGBO(230, 0, 35, 1);
  static const Color purple = Color.fromARGB(255, 87, 42, 105);
  static const Color tiktok = Color.fromRGBO(0, 0, 0, 1);
  static const Color twitter = Color.fromRGBO(38, 167, 222, 1);
  static const Color snapChat = Color.fromRGBO(255, 252, 0, 1);
  static const Color behance = Color.fromRGBO(5, 62, 255, 1);
  static const Color vimeo = Color.fromRGBO(134, 201, 239, 1);
  static const Color googleMaps = Color.fromRGBO(52, 168, 83, 1);
  static const Color appStore = Color.fromRGBO(0, 122, 255, 1);
  static const Color googlePlay = Color.fromRGBO(255, 212, 0, 1);
  static const Color appGallery = Color.fromRGBO(206, 14, 45, 1);
  // --------------------
  static const Color telegramLightBlue = Color.fromARGB(255, 56, 176, 227);
  static const Color telegramDarkBlue = Color.fromARGB(255, 29, 147, 210);
  // -----------------------------------------------------------------------------
}
