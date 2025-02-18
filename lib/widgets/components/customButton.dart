import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import '../../controllers/theme/theme_controller.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool disabled;
  final double? fontSize;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color? defaultColor;
  final Color? textColor;
  final Color borderColor;
  final double? width;
  final double? height;
  final double radius;
  final FontWeight fontWeight;
  final Widget icon;
  final Widget rightIcon;

  CustomButton(
    this.title, {
    required this.onPressed,
    this.disabled = false,
    this.fontSize,
    this.paddingVertical = 14,
    this.paddingHorizontal = 16,
    this.defaultColor = Colors.white,
    this.textColor,
    this.borderColor = Colors.transparent,
    this.fontWeight = FontWeight.w700,
    this.width,
    this.height = 48,
    this.radius = 100,
    this.icon = const SizedBox(),
    this.rightIcon = const SizedBox(),
  });

  final ThemeController _ctrl = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: AbsorbPointer(
        absorbing: disabled,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              CText(
                title,
                color: !disabled
                    ? textColor ?? Colors.white
                    : _ctrl.disabled.value,
                fontSize: fontSize,
              ),
              rightIcon,
            ],
          ),
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(10.0),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: paddingVertical,
              ),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            side: WidgetStateProperty.all<BorderSide>(
              BorderSide(color: borderColor),
            ),
            backgroundColor: WidgetStateProperty.all<Color>(
              !disabled ? defaultColor ?? Colors.transparent : Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}
