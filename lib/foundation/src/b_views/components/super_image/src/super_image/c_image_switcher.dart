part of super_image;

class ImageSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageSwitcher({
    required this.width,
    required this.height,
    required this.pic,
    required this.boxFit,
    required this.scale,
    required this.iconColor,
    required this.loading,
    required this.backgroundColor,
    required this.package,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double? width;
  final double height;
  final BoxFit? boxFit;
  final double? scale;
  final Color? iconColor;
  final bool loading;
  final Color? backgroundColor;
  final String? package;
  // -----------------------------------------------------------------------------
  static const bool _gaplessPlayback = true;
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _errorBuilder (_, Object error, StackTrace? stackTrace) {
    // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : error : $error');
    return Container(
      width: width,
      height: height,
      color: const Color.fromARGB(10, 255, 255, 255),
      // child: const SuperVerse(
      //   verse: Verse(
      //     text: 'phid_error',
      //     translate: true,
      //     casing: Casing.lowerCase,
      //   ),
      //   size: 0,
      //   maxLines: 2,
      // ),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _loadingBuilder(BuildContext _, Widget? child, ImageChunkEvent? imageChunkEvent){

    // blog('SUPER IMAGE LOADING BUILDER : imageChunkEvent.cumulativeBytesLoaded : ${imageChunkEvent?.cumulativeBytesLoaded} / ${imageChunkEvent?.expectedTotalBytes}');

    /// AFTER LOADED
    if (
        imageChunkEvent == null
        ||
        imageChunkEvent.expectedTotalBytes == null
        ||
        width == null
    ){
      return child ?? const SizedBox();
    }
    /// WHILE LOADING
    else {

      final int _bytes = imageChunkEvent.expectedTotalBytes ?? 0;

      if (_bytes > 0) {

        final double _percentage = imageChunkEvent.cumulativeBytesLoaded / _bytes;

        return Container(
          width: width,
          height: height,
          color: const Color.fromARGB(50, 255, 255, 255),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * _percentage,
            color: backgroundColor ?? const Color.fromARGB(20, 255, 255, 255),
          ),
        );

      }
      else {
        return child ?? _emptyBox();
      }

    }

  }
  // --------------------
  ///DEPRECATED
  /*
  Widget _futureBytesBuilder (BuildContext ctx, AsyncSnapshot<Uint8List> snapshot){

    return FutureImage(
      snapshot: snapshot,
      width: width,
      height: height,
      boxFit: boxFit,
      errorBuilder: _errorBuilder,
    );

  }
   */
  // -----------------------------------------------------------------------------
  Widget _emptyBox(){
    return SizedBox(
      width: width,
      height: height,
      // color: Colorz.errorColor,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (loading == true){
      return InfiniteLoadingBox(
        width: width!,
        height: height,
        color: iconColor,
        backgroundColor: backgroundColor ?? const Color.fromARGB(50, 255, 255, 255),
      );
    }

    /// HAS IMAGE
    else if (pic != null && pic != '' && width != null){

      final BoxFit _boxFit = boxFit ?? BoxFit.cover;

      if (pic is IconData){
        return Container(
          width: width,
          height: height * (scale ?? 1) * 1.3,
          alignment: Alignment.center,
          child: Icon(
            pic,
            key: const ValueKey<String>('SuperImage_iconData'),
            // semanticLabel: 'SuperImage_iconData',
            size: height * (scale ?? 1) * 1.3,
            color: iconColor ?? const Color.fromARGB(255, 255, 255, 255),
            // weight: 1,
            // fill: 1,
            // grade: 1,
            // opticalSize: 1,
            // textDirection: TextDirection.ltr,
            // shadows: [],
          ).build(context),
        );
      }

      /// UINT8LIST
      else if (_Helpers.objectIsUint8List(pic) == true){

        return Image.memory(
          pic!,
          key: const ValueKey<String>('SuperImage_bytes'),
          fit: _boxFit,
          width: width,
          height: height,
          color: iconColor,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );

        // return CachelessImage(
        //   key: const ValueKey<String>('SuperImage_bytes'),
        //   bytes: pic,
        //   width: width,
        //   height: height,
        //   color: backgroundColor,
        //   boxFit: _boxFit,
        //   // blendMode: BlendMode.color,
        // );

      }

      /// SUPER FILE
      // else if (pic is SuperFile == true){
      //   return SuperFileViewer(
      //     key: const ValueKey<String>('SuperImage_superFile'),
      //     file: pic,
      //     width: width,
      //     height: height,
      //     fit: _boxFit,
      //   );
      // }

      /// FILE
      else if (_Helpers.objectIsFile(pic) == true){

        return Image.file(
          pic,
          key: const ValueKey<String>('SuperImage_file'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
        );
      }

      /// X FILE
      // else if (ObjectCheck.objectIsXFile(pic) == true){
      //   return Image(
      //     image: XFileImage(pic),
      //     key: const ValueKey<String>('SuperImage_xfile'),
      //     fit: _boxFit,
      //     width: width,
      //     height: height,
      //     errorBuilder: _errorBuilder,
      //     gaplessPlayback: _gaplessPlayback,
      //   );
      // }

      /// URL
      else if (_Helpers.isAbsoluteURL(pic) == true){

        return Image.network(
          pic.trim(),
          key: const ValueKey<String>('SuperImage_url'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          gaplessPlayback: _gaplessPlayback,
          loadingBuilder: _loadingBuilder,
        );

      }

      /// JPG OR PNG
      else if (_Helpers.objectIsJPGorPNG(pic) == true){

        return Image.asset(
          pic,
          key: const ValueKey<String>('SuperImage_png_or_jpg'),
          fit: _boxFit,
          width: width,
          height: height,
          errorBuilder: _errorBuilder,
          scale: 1,
          gaplessPlayback: _gaplessPlayback,
          package: package,
        );

      }

      /// SVG
      else if (_Helpers.objectIsSVG(pic) == true){
        assert(_Helpers.objectIsSVG(pic) == false, 'svg is not supported');
        return Container();
        // return WebsafeSvg.asset(
        //   pic,
        //   fit: _boxFit,
        //   colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
        //   width: width,
        //   height: height,
        //   package: package,
        //
        // );
      }

      /// UI.IMAGE
      else if (_Helpers.objectIsUiImage(pic) == true){

        final ui.Image _uiImage = pic;

        return RawImage(
          /// MAIN
          key: const ValueKey<String>('SuperImage_UIIMAGE'),
          // debugImageLabel: ,

          /// IMAGE
          image: _uiImage,
          // repeat: ImageRepeat.noRepeat, // DEFAULT

          /// SIZES
          width: width,
          height: height,
          scale: scale ?? 1,

          /// COLORS
          // color: iconColor,
          // opacity: 0.5,
          // colorBlendMode: BlendMode.srcATop,
          // filterQuality: FilterQuality.low, // DEFAULT
          // invertColors: true, // DEFAULT

          /// POSITIONING
          // alignment: Alignment.center, // DEFAULT
          fit: _boxFit,

          /// DUNNO
          // centerSlice: ,
          // isAntiAlias: ,
          // matchTextDirection: false, // DEFAULT : flips image horizontally
        );
      }

      /// IMG.IMAGE
      else if (_Helpers.objectIsImgImage(pic) == true){

        final Uint8List _bytes = img.encodeJpg(pic,
            // quality: 100,
        );

        return CachelessImage(
          key: const ValueKey<String>('SuperImage_imgImage'),
          bytes: _bytes,
          width: width,
          height: height,
          color: backgroundColor,
          boxFit: _boxFit,
        );
      }

      /// STRING - DOUBLE - INT
      else if (pic is String || pic is String? || pic is num || pic is num?){

        final String _text = pic.toString();

        return Center(
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: FittedBox(
              child: SuperText(
                // boxWidth: width,
                // boxHeight: height,
                boxColor: backgroundColor,
                text: _text,
                weight: FontWeight.w100,
                // letterSpacing: 1,
                // font: BldrsThemeFonts.fontHead,
                // appIsLTR: true,
                textHeight: height * (scale ?? 1) * 1.4,
                textColor: iconColor ?? const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        );
      }

      /// NEITHER ANY OF ABOVE
      else {

        // blog('SUPER IMAGE ERROR : ${pic.runtimeType} : $pic');

        return _emptyBox();

      }

    }

    /// EMPTY
    else {
      return _emptyBox();
    }

  }
  // -----------------------------------------------------------------------------
}
