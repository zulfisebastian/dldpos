import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import 'text/ctext.dart';

class NumPadPin extends StatelessWidget {
  NumPadPin({
    Key? key,
    required this.num,
    required this.onPressed,
  }) : super(key: key);

  final String num;
  final VoidCallback onPressed;

  final ThemeController _theme = Get.find(tag: 'ThemeController');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Ink(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: _theme.primary[3],
          ),
          child: InkWell(
            onTap: () {
              onPressed();
            },
            borderRadius: BorderRadius.circular(80),
            child: Center(
              child: CText(
                num,
                fontSize: 32,
                color: _theme.pureWhite.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NumPad extends StatelessWidget {
  NumPad({required this.onPress});

  final Function(String, String) onPress;

  final ThemeController _theme = Get.find(tag: 'ThemeController');

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: NumPadPin(
                  num: "1",
                  onPressed: () => onPress("1", "add"),
                ),
              ),
              Expanded(
                child: NumPadPin(
                  num: "2",
                  onPressed: () => onPress("2", "add"),
                ),
              ),
              Expanded(
                child: NumPadPin(
                  num: "3",
                  onPressed: () => onPress("3", "add"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: NumPadPin(
                  num: "4",
                  onPressed: () => onPress("4", "add"),
                ),
              ),
              Expanded(
                child: NumPadPin(
                  num: "5",
                  onPressed: () => onPress("5", "add"),
                ),
              ),
              Expanded(
                child: NumPadPin(
                  num: "6",
                  onPressed: () => onPress("6", "add"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            spacing: 16,
            children: [
              Expanded(
                child: NumPadPin(
                  num: "7",
                  onPressed: () => onPress("7", "add"),
                ),
              ),
              Expanded(
                child: NumPadPin(
                  num: "8",
                  onPressed: () => onPress("8", "add"),
                ),
              ),
              Expanded(
                child: NumPadPin(
                  num: "9",
                  onPressed: () => onPress("9", "add"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            spacing: 16,
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: NumPadPin(
                  num: "0",
                  onPressed: () => onPress("0", "add"),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Ink(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: _theme.primary[3],
                      ),
                      child: InkWell(
                        onTap: () {
                          onPress("", "remove");
                        },
                        borderRadius: BorderRadius.circular(80),
                        child: Center(
                          child: Icon(
                            Icons.backspace_outlined,
                            color: _theme.pureWhite.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
