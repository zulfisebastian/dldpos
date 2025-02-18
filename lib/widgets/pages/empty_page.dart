import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../components/text/ctext.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  EmptyPage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final ThemeController _theme = Get.find(tag: 'ThemeController');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/ic_empty.svg",
            height: 90,
            width: 90,
          ),
          SizedBox(
            height: 20,
          ),
          CText(
            text,
            fontSize: 20,
            color: _theme.pureBlack.value,
            overflow: TextOverflow.visible,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
