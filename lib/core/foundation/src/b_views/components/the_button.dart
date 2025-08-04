part of app_foundations;

class TheButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheButton({
    required this.text,
    required this.font,
    this.height,
    this.width,
    this.verseScaleFactor = 1.0,
    this.verseCentered = true,
    this.verseColor,
    this.color,
    this.borderColor,
    this.splashColor,
    this.icon,
    this.margins,
    this.corners,
    this.onTap,
    Key? key,
  }) : super(key: key);
  // --------------------
  final double? height;
  final double? width;
  final String text;
  final String font;
  final double verseScaleFactor;
  final bool verseCentered;
  final Color? verseColor;
  final Color? color;
  final Color? borderColor;
  final Color? splashColor;
  final IconData? icon;
  final EdgeInsets? margins;
  final BorderRadius? corners;
  final VoidCallback? onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins,
      height: height,
      width: width,
      child: Material(
        color: color ?? Colors.transparent,
        borderRadius: corners ?? BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: corners ?? BorderRadius.circular(8),
          splashColor: splashColor ?? Colors.grey.withOpacity(0.2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: corners ?? BorderRadius.circular(8),
              border: Border.all(color: borderColor ?? Colors.transparent),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: verseCentered
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: verseColor ?? Colors.white,
                    size: 20 * verseScaleFactor,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign:
                    verseCentered ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      fontFamily: font,
                      fontSize: 16 * verseScaleFactor,
                      fontWeight: FontWeight.w600,
                      color: verseColor ?? Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // --------------------------------------------------------------------------
}
