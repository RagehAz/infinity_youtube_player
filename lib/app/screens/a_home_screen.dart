import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/shared_components/super_image/super_image.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/iconz.dart';

class HomeScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomeScreen({super.key});
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const TheLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SuperText(
            text: 'Click on the video link in the website to open the video',
            maxLines: 4,
            margins: 15,
            textHeight: 30,
          ),
          SuperImage(
            width: 150,
            height: 150,
            pic: Iconz.logo,
            corners: 20,
            loading: false,
          ),
        ],
      ),
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
