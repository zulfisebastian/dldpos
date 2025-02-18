import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/theme/theme_controller.dart';
import 'text/ctext.dart';

// ignore: must_be_immutable
class CustomInputArea extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String title;
  final String hintText;
  final String errorMessage;
  final Function(String) onChanged;
  final bool isSecureText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
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

  CustomInputArea({
    required this.textEditingController,
    required this.title,
    required this.hintText,
    required this.errorMessage,
    required this.onChanged,
    this.focusNode,
    this.isSecureText = false,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.height,
    this.width,
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
    this.radius = 6,
  });

  @override
  State<CustomInputArea> createState() => _CustomInputAreaState();
}

class _CustomInputAreaState extends State<CustomInputArea> {
  ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          widget.title,
          color: widget.readOnly
              ? _theme.pureBlack.value.withOpacity(0.7)
              : _theme.pureBlack.value,
        ),
        Container(
          height: widget.height,
          width: widget.width,
          padding: EdgeInsets.only(
            left: 4,
            top: 4,
            right: 0,
            bottom: 10,
          ),
          child: TextFormField(
            textAlign: widget.textAlign,
            readOnly: widget.readOnly,
            textInputAction: widget.textInputAction,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            maxLength: widget.maxInput,
            maxLines: widget.maxLines,
            minLines: 4,
            style: GoogleFonts.inter(
              color:
                  widget.readOnly ? _theme.neutral[1] : _theme.pureBlack.value,
              fontSize: 14,
              fontWeight: widget.fontWeight,
            ),
            obscureText: widget.isSecureText,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              fillColor:
                  widget.readOnly ? _theme.neutral[0] : _theme.pureWhite.value,
              filled: true,
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle: GoogleFonts.plusJakartaSans(
                color: _theme.neutral[0],
              ),
              errorStyle: GoogleFonts.plusJakartaSans(height: 0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.readOnly ? _theme.neutral[1] : _theme.line.value,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.readOnly ? _theme.neutral[1] : _theme.primary[0],
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.readOnly ? _theme.neutral[1] : _theme.error[0],
                ),
              ),
              suffixIcon: widget.readOnly ? null : widget.suffixIcon,
              prefixIcon: widget.readOnly ? null : widget.prefixIcon,
            ),
            textCapitalization: widget.textCapitalization,
            buildCounter: (_,
                    {required currentLength, maxLength, required isFocused}) =>
                Container(
              alignment: Alignment.centerRight,
              child: Text(
                currentLength.toString() + "/" + maxLength.toString(),
                style: GoogleFonts.plusJakartaSans(
                  color: _theme.neutral[0],
                ),
              ),
            ),
            validator: widget.validator ??
                (value) {
                  if (value!.length <= 0)
                    return widget.errorMessage;
                  else
                    return null;
                },
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
