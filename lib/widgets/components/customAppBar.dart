import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'text/ctext.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? action;
  final Widget? leading;
  final double? elevation;

  CustomAppBar({
    required this.context,
    required this.title,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.action,
    this.leading,
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: Material(
        elevation: elevation!,
        shadowColor: Colors.black26,
        child: Container(
          color: backgroundColor,
          child: AppBar(
            scrolledUnderElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            elevation: 0,
            backgroundColor: backgroundColor,
            centerTitle: false,
            actions: [
              action ?? Container(),
            ],
            titleSpacing: 0,
            title: CText(
              title,
              color: textColor!,
              fontSize: 14,
            ),
            leading: leading ??
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: textColor!,
                      size: 16,
                    ),
                  ),
                ),
            leadingWidth: 45,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
