import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildtext(
    {required String text,
    Color? fontcolor,
    double? fontsize,
    int maxlines = 2,
    FontWeight? fontweight,
    Color color = Colors.black}) {
  return Text(
    text,
    maxLines: maxlines,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
        color: fontcolor ?? Colors.black,
        fontSize: fontsize ?? 15,
        fontWeight: fontweight),
  );
}

Widget buildTextIcon({
  required String text,
  required IconData icon, // The icon to display
  Color? fontColor,
  double? fontSize,
  int maxLines = 2,
  FontWeight? fontWeight,
  Color? iconColor, // Optional color for the icon
  double? iconSize, // Optional size for the icon
  double spacing = 8.0, // Space between text and icon
  bool iconBeforeText =
      true, // Whether the icon should appear before or after the text
}) {
  final textWidget = Text(
    text,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      color: fontColor ?? Colors.black,
      fontSize: fontSize ?? 15,
      fontWeight: fontWeight,
    ),
  );

  final iconWidget = Icon(
    icon,
    color: iconColor ?? Colors.black,
    size: iconSize ?? 24,
  );

  return Row(
    mainAxisSize: MainAxisSize.min, // Shrinks to fit the content
    children: iconBeforeText
        ? [
            iconWidget,
            SizedBox(width: spacing),
            textWidget,
          ]
        : [
            textWidget,
            SizedBox(width: spacing),
            iconWidget,
          ],
  );
}
