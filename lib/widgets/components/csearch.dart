// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/theme/theme_controller.dart';

class CSearch extends StatelessWidget {
  CSearch({
    required this.textEditingController,
    required this.hintText,
    required this.errorMessage,
    required this.onChanged,
    this.focusNode,
    this.isSecureText = false,
    this.textInputAction,
    this.validator,
    this.height,
    this.width,
    this.fieldContent,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.maxInput = 50,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.textAlign = TextAlign.left,
    this.isUsingSymbol = false,
    this.isWithShadow = false,
    this.borderSideWidth = 0.1,
    this.fontWeight = FontWeight.w400,
    this.radius = 30,
  });

  final String? fieldContent;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String hintText;
  final String errorMessage;
  final Function(String) onChanged;
  final bool isSecureText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final double? height;
  final double? width;
  final TextInputType keyboardType;
  final int maxInput;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  final bool isUsingSymbol;
  final TextAlign textAlign;
  final double borderSideWidth;
  final bool isWithShadow;
  final FontWeight fontWeight;
  final double radius;

  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    inputFormatters = [
      LengthLimitingTextInputFormatter(maxInput),
      if (isUsingSymbol) FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
    ];
    return Container(
      height: height,
      width: width,
      decoration: isWithShadow
          ? BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _theme.line.value,
                  blurRadius: 30.0,
                  offset: Offset(0, 10),
                )
              ],
            )
          : BoxDecoration(),
      child: TextFormField(
        textAlign: textAlign,
        readOnly: readOnly,
        textInputAction: textInputAction,
        controller: textEditingController,
        focusNode: focusNode,
        maxLines: maxLines,
        style: GoogleFonts.inter(
          color: readOnly ? _theme.neutral[1] : _theme.pureBlack.value,
          fontSize: 14,
          fontWeight: fontWeight,
        ),
        obscureText: isSecureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          fillColor: readOnly ? _theme.neutral[0] : _theme.pureWhite.value,
          filled: true,
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: GoogleFonts.plusJakartaSans(color: _theme.neutral[0]),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _theme.line.value,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: readOnly ? _theme.neutral[1] : _theme.primary[0],
              width: 1,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _theme.error[1],
              width: 1,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: _theme.pureBlack.value.withOpacity(0.7),
            ),
          ),
        ),
        textCapitalization: textCapitalization,
        validator: validator ??
            (value) {
              if (value!.length <= 0)
                return errorMessage;
              else
                return null;
            },
        onChanged: onChanged,
      ),
    );
  }
}
