import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CText extends StatelessWidget {
  final dynamic title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow overflow;
  final TextAlign? align;
  final bool isItalic;
  final TextDecoration? decoration;
  final int? maxLines;
  final double thickness;
  final Color color;
  final double lineHeight;
  final double spacing;

  CText(
    this.title, {
    this.fontSize = 14,
    this.fontWeight,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.maxLines,
    this.align,
    this.isItalic = false,
    required this.color,
    this.lineHeight = 1.3,
    this.thickness = 4,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      style: GoogleFonts.plusJakartaSans(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationThickness: thickness,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        height: lineHeight,
        letterSpacing: spacing,
      ),
      overflow: overflow,
      textAlign: align,
      maxLines: maxLines,
    );
  }
}
