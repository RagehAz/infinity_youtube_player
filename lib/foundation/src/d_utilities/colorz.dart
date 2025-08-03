part of app_foundations;

abstract class Colorz {
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
  static const int _whiteR = 247;
  static const int _whiteG = 247;
  static const int _whiteB = 247;
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
  static const Color grey50 = Color.fromARGB(50, 121, 121, 121);
  static const Color grey80 = Color.fromARGB(80, 121, 121, 121);
  static const Color grey150 = Color.fromARGB(150, 121, 121, 121);
  static const Color grey255 = Color.fromARGB(255, 200, 200, 200);
  // --------------------
  static const Color lightGrey255 = Color.fromARGB(255, 220, 220, 220);
  // --------------------
  static const Color darkGrey255 = Color.fromARGB(255, 180, 180, 180);
  static const Color darkGrey80 = Color.fromARGB(80, 180, 180, 180);
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
  // -------------------------------------------------------------------------
  static const List<Color> allColorz = <Color>[
    nothing,
    black0,
    black10,
    black20,
    black50,
    black80,
    black125,
    black150,
    black200,
    black230,
    black255,
    white10,
    white20,
    white30,
    white50,
    white80,
    white125,
    white200,
    white230,
    white255,
    grey50,
    grey80,
    grey255,
    lightGrey255,
    darkGrey255,
    facebook,
    linkedIn,
    googleRed,
    telegramLightBlue,
    telegramDarkBlue,
  ];
  // -----------------------------------------------------------------------------
}
