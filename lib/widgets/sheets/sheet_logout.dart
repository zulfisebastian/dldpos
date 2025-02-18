import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../components/customButton.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetLogout extends StatelessWidget {
  final VoidCallback onTap;

  SheetLogout({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final ThemeController _theme = Get.find(tag: 'ThemeController');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: _theme.pureWhite.value,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DraggableBottomSheet(),
              SizedBox(
                height: 16,
              ),
              Obx(
                () => CText(
                  "Are you sure want to logout from app?",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  lineHeight: 1.5,
                  overflow: TextOverflow.visible,
                  color: _theme.pureBlack.value,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      "Cancel",
                      defaultColor: Colors.black12,
                      textColor: _theme.pureBlack.value,
                      radius: 10,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      "Sign Out",
                      radius: 10,
                      defaultColor: _theme.error[0],
                      textColor: _theme.error[4],
                      onPressed: () {
                        onTap();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
