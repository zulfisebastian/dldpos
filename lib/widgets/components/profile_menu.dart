import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/dimension.dart';
import 'text/ctext.dart';

class ProfileMenu extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final Color titleColor;
  final Widget icon;
  final bool isWarning;

  ProfileMenu({
    Key? key,
    required this.onClick,
    required this.title,
    required this.titleColor,
    required this.icon,
    this.isWarning = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: CDimension.space20,
          horizontal: CDimension.space12,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black26,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CText(
                title,
                fontSize: CDimension.space16,
                color: titleColor,
              ),
            ),
            SizedBox(
              width: CDimension.space12,
            ),
            if (isWarning)
              SvgPicture.asset(
                "assets/icons/ic_info.svg",
                width: 20,
              ),
            SizedBox(
              width: CDimension.space12,
            ),
            icon,
            SizedBox(
              width: CDimension.space12,
            ),
          ],
        ),
      ),
    );
  }
}
