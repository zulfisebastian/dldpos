import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/dimension.dart';
import '../../constants/size.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/input_formatter.dart';

class CustomInputNumber extends StatefulWidget {
  CustomInputNumber({
    required this.textEditingController,
    required this.hintText,
    required this.errorMessage,
    required this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.height,
    this.width,
    this.readOnly = false,
    this.maxInput = 50,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.center,
    this.borderSideWidth = 0.1,
    this.fontWeight = FontWeight.w400,
    this.radius = 6,
  });

  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String hintText;
  final String errorMessage;
  final Function(String) onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final double? height;
  final double? width;
  final int maxInput;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final double borderSideWidth;
  final FontWeight fontWeight;
  final double radius;

  @override
  State<CustomInputNumber> createState() => _CustomInputNumberState();
}

class _CustomInputNumberState extends State<CustomInputNumber> {
  ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    var inputFormatters = [
      LengthLimitingTextInputFormatter(widget.maxInput),
      ThousandsSeparatorInputFormatter(),
    ];
    return Container(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        textAlign: widget.textAlign,
        readOnly: widget.readOnly,
        textInputAction: widget.textInputAction,
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        maxLines: widget.maxLines,
        keyboardType: TextInputType.number,
        inputFormatters: inputFormatters,
        style: GoogleFonts.plusJakartaSans(
          fontSize: CDimension.space40,
          color: _theme.primary[4],
        ),
        decoration: InputDecoration(
          fillColor: _theme.pureWhite.value,
          filled: true,
          hintText: widget.hintText,
          border: InputBorder.none,
          hintStyle: GoogleFonts.plusJakartaSans(
            color: _theme.neutral[0],
            fontSize: CFontSize.font20,
          ),
          errorStyle: GoogleFonts.plusJakartaSans(height: 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            borderSide: BorderSide(
              color: _theme.line.value,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            borderSide: BorderSide(
              color: widget.readOnly ? _theme.neutral[1] : _theme.primary[0],
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            borderSide: BorderSide(
              color: _theme.error[1],
              width: 1,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        textCapitalization: widget.textCapitalization,
        validator: widget.validator ??
            (value) {
              if (value!.length <= 0)
                return widget.errorMessage;
              else
                return null;
            },
        onChanged: widget.onChanged,
      ),
    );
  }
}
