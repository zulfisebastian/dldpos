import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/theme/theme_controller.dart';
import 'text/ctext.dart';

class CustomInputPass extends StatefulWidget {
  const CustomInputPass({
    Key? key,
    required this.controller,
    required this.title,
    required this.errorMessage,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.fontSize = 14,
    this.fontWeight,
    this.prefixIcon,
    this.maxLength,
    this.inputFormatter = const [],
    this.radius = 6,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String? hintText;
  final String errorMessage;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final int? maxLength;
  final List<TextInputFormatter> inputFormatter;
  final Function(String) onChanged;
  final double radius;

  @override
  _CustomInputPassState createState() => _CustomInputPassState();
}

class _CustomInputPassState extends State<CustomInputPass> {
  ThemeController _theme = Get.find(tag: "ThemeController");

  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != "")
          CText(
            widget.title,
            color: _theme.pureBlack.value,
          ),
        TextFormField(
          controller: widget.controller,
          style: GoogleFonts.inter(
            color: _theme.pureBlack.value,
            fontSize: widget.fontSize,
          ),
          obscureText: _obscure,
          textAlign: widget.textAlign,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            fillColor: _theme.pureWhite.value,
            filled: true,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              color: _theme.neutral[0],
            ),
            counterText: "",
            errorStyle: GoogleFonts.plusJakartaSans(height: 0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _theme.line.value,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _theme.primary[0],
                width: 1,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: _theme.error[1],
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            isDense: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                _obscure = !_obscure;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Obx(
                  () => Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: _theme.primary[4],
                  ),
                ),
              ),
            ),
          ),
          validator: (value) {
            if (value!.length <= 0)
              return widget.errorMessage;
            else
              return null;
          },
          inputFormatters: widget.inputFormatter,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
