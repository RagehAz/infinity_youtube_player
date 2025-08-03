part of the_youtube_player;

class SuperVideoScale {
  // --------------------------------------------------------------------------

  /// HEIGHT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getHeightByAspectRatio({
    required double? aspectRatio,
    required double width,
    required bool force169,
  }){
    double _output = width / (16 / 9);

    if (aspectRatio != null && force169 == false) {
      /// AspectRatio = (widthA / heightA)
      ///             = (widthB / heightB)
      ///
      /// so heightB = widthB / aspectRatio
      _output = width / aspectRatio;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getHeightOnScreen({
    required double videoWidth,
    required double videoHeight,
    required double canvasWidth,
    required double canvasHeight,
  }){

    final Dimensions _fitVideoDims = getDimsOnScreen(
      canvasHeight: canvasHeight,
      canvasWidth: canvasWidth,
      videoHeight: videoHeight,
      videoWidth: videoWidth,
    );

    return _fitVideoDims.height ?? 0;

    // final Dimensions _dims = Dimensions(width: videoWidth, height: videoHeight);
    //
    // final double _areaHeight = areaHeight;
    //
    // final double _videoRatio = _dims.getAspectRatio();  // w / h
    // final double _areaWidth = areaWidth;
    //
    // if (_dims.checkIsSquared() == true){
    //   return _areaWidth > _areaHeight ? _areaHeight : _areaWidth;
    // }
    // else if (_dims.checkIsLandscape() == true){
    //   return _areaWidth / _videoRatio;
    // }
    // else if (_dims.checkIsPortrait() == true){
    //   return _areaHeight;
    // }
    // else {
    //   return _areaHeight;
    // }

  }
  // --------------------------------------------------------------------------

  /// WIDTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getWidthOnScreen({
    required double videoWidth,
    required double videoHeight,
    required double canvasWidth,
    required double canvasHeight,
  }){

    final Dimensions _fitVideoDims = getDimsOnScreen(
      canvasHeight: canvasHeight,
      canvasWidth: canvasWidth,
      videoHeight: videoHeight,
      videoWidth: videoWidth,
    );

    return _fitVideoDims.width ?? 0;

    // final double _videoRatio = _video.getAspectRatio();  // w / h
    //
    // // blog('===> _cropped : $_video : $_videoRatio');
    // // final Dimensions _real = Dimensions.fromSize(controller.videoDimension);
    // // blog('===> real : $_real : ${_real.getAspectRatio()}');
    // // blog('===> areaWidth : $areaWidth : areaHeight : $areaHeight');
    //
    // return _videoRatio * getHeightOnScreen(
    //   videoWidth: videoWidth,
    //   videoHeight: videoHeight,
    //   areaWidth: canvasWidth,
    //   areaHeight: canvasHeight,
    // );

  }
  // --------------------------------------------------------------------------

  /// DIMS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Dimensions getDimsOnScreen({
    required double videoWidth,
    required double videoHeight,
    required double canvasWidth,
    required double canvasHeight,
  }){
    final Dimensions _canvas = Dimensions(width: canvasWidth, height: canvasHeight);
    final Dimensions _video = Dimensions(width: videoWidth, height: videoHeight);

    return Dimensions.fitGraphicToCanvas(
      canvas: _canvas,
      graphic: _video,
      boxFit: BoxFit.contain,
    );
  }
  // --------------------------------------------------------------------------

  /// CORNERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius getCorners({
    required double width,
    required dynamic corners,
  }) {
    return superCorners(
      corners: corners ?? BorderRadius.circular(width * 0.02),
    );
  }
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
  // --------------------------------------------------------------------------
}
