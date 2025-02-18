import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/input_formatter.dart';

class CustomInputForm extends StatefulWidget {
  CustomInputForm({
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
    this.textAlign = TextAlign.left,
    this.isUsingSymbol = false,
    this.isWithShadow = false,
    this.isForCard = false,
    this.isCurrency = false,
    this.borderSideWidth = 0.1,
    this.fontWeight = FontWeight.w400,
    this.radius = 6,
  });

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
  final bool isUsingSymbol;
  final TextAlign textAlign;
  final double borderSideWidth;
  final bool isWithShadow;
  final bool isForCard;
  final bool isCurrency;
  final FontWeight fontWeight;
  final double radius;

  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    var inputFormatters = widget.isForCard
        ? [
            LengthLimitingTextInputFormatter(widget.maxInput),
            FilteringTextInputFormatter.digitsOnly,
            CardFormatter(),
          ]
        : widget.isCurrency
            ? [
                LengthLimitingTextInputFormatter(widget.maxInput),
                ThousandsSeparatorInputFormatter(),
              ]
            : [
                LengthLimitingTextInputFormatter(widget.maxInput),
                if (widget.isUsingSymbol)
                  FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
              ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != "")
          CText(
            widget.title,
            color: widget.readOnly
                ? _theme.pureBlack.value.withOpacity(0.7)
                : _theme.pureBlack.value,
          ),
        Container(
          height: widget.height,
          width: widget.width,
          child: TextFormField(
            textAlign: widget.textAlign,
            readOnly: widget.readOnly,
            textInputAction: widget.textInputAction,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 14 * 4),
            style: GoogleFonts.plusJakartaSans(
              color:
                  widget.readOnly ? _theme.neutral[1] : _theme.pureBlack.value,
              fontSize: 14,
            ),
            obscureText: widget.isSecureText,
            keyboardType: widget.keyboardType,
            inputFormatters: inputFormatters,
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
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              suffixIcon: widget.readOnly ? null : widget.suffixIcon,
              prefixIcon: widget.readOnly ? null : widget.prefixIcon,
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
        ),
      ],
    );
  }
}
