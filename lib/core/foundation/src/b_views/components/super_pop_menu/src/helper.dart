part of super_pop_menu;

abstract class _Helpers {
  // --------------------
  static const Color youtube = Color.fromRGBO(255, 0, 0, 1);
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double screenWidth(BuildContext context) {
    return context.mounted == true ? MediaQuery.sizeOf(context).width : 0;
    // return MediaQuery.of(context).size.width;
  }
  // --------------------------------------------------------------------------
}
