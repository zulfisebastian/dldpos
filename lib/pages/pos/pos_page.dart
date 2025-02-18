import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/ctoast.dart';
import 'package:dld/widgets/components/customAppBar.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosPage extends StatefulWidget {
  @override
  _PosPageState createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  String inputString = "";
  String input = "";
  int total = 0;
  bool isNewInput = true;

  void onButtonPressed(String value) {
    setState(() {
      if (value == "c") {
        input = "";
        inputString = "";
        total = 0;
        isNewInput = true;
      } else if (value == "+") {
        if (input.isNotEmpty) {
          inputString += value;
          total += int.parse(input);
          input = "";
          isNewInput = true;
        }
      } else if (value == "=") {
        inputString += value;
        if (input.isNotEmpty) {
          total += int.parse(input);
          input = "0";
        }
        inputString += total.toString();
        input = total.toString();
        isNewInput = true;
      } else if (value == "Pay") {
        CToast.showWithoutCOntext(
          "Success",
          _theme.pureBlack.value,
          _theme.pureWhite.value,
        );
      } else {
        inputString += value;
        if (isNewInput) {
          input = value;
          isNewInput = false;
        } else {
          input += value;
        }
      }
    });
  }

  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.pureWhite.value,
      appBar: CustomAppBar(
        context: context,
        title: "Order",
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: _theme.pureBlack.value.withAlpha(10),
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    inputString.isEmpty ? "0" : inputString,
                    style: TextStyle(
                      fontSize: 24,
                      color: _theme.pureBlack.value,
                    ),
                  ),
                  Text(
                    "${StringExt.thousandFormatter(total)}",
                    style: TextStyle(fontSize: 56, color: _theme.primary[5]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: _theme.pureWhite.value,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(text: "7", onTap: () => onButtonPressed("7")),
                        POSButton(text: "8", onTap: () => onButtonPressed("8")),
                        POSButton(text: "9", onTap: () => onButtonPressed("9")),
                        POSButton(text: "c", onTap: () => onButtonPressed("c")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(text: "4", onTap: () => onButtonPressed("4")),
                        POSButton(text: "5", onTap: () => onButtonPressed("5")),
                        POSButton(text: "6", onTap: () => onButtonPressed("6")),
                        POSButton(text: "+", onTap: () => onButtonPressed("+")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(text: "1", onTap: () => onButtonPressed("1")),
                        POSButton(text: "2", onTap: () => onButtonPressed("2")),
                        POSButton(text: "3", onTap: () => onButtonPressed("3")),
                        POSButton(text: "=", onTap: () => onButtonPressed("=")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(text: "0", onTap: () => onButtonPressed("0")),
                        POSButton(
                            text: "00", onTap: () => onButtonPressed("00")),
                        POSButton(
                          text: "Pay",
                          onTap: () => onButtonPressed("Pay"),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class POSButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final int flex;

  POSButton({
    required this.text,
    required this.onTap,
    this.flex = 1,
  });

  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: checkTextType(text) == "ANGKA"
                  ? HexColor.fromHex("262626")
                  : checkTextType(text) == "SYMBOL"
                      ? HexColor.fromHex("8CCE82")
                      : checkTextType(text) == "CLEAR"
                          ? HexColor.fromHex("E84A57")
                          : _theme.primary[4],
            ),
            color: checkTextType(text) == "ANGKA"
                ? HexColor.fromHex("262626").withAlpha(220)
                : checkTextType(text) == "SYMBOL"
                    ? HexColor.fromHex("8CCE82").withAlpha(220)
                    : checkTextType(text) == "CLEAR"
                        ? HexColor.fromHex("E84A57").withAlpha(220)
                        : _theme.primary[4],
          ),
          child: Center(
            child: checkTextType(text) == "ANGKA"
                ? CText(
                    text,
                    fontSize: 40,
                    color: Colors.white,
                  )
                : checkTextType(text) == "CLEAR"
                    ? CText(
                        "C",
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      )
                    : checkTextType(text) == "SYMBOL"
                        ? Text(
                            text,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            spacing: 8,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CText(
                                "PAY",
                                fontSize: 32,
                                spacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ],
                          ),
          ),
        ),
      ),
    );
  }

  checkTextType(String _text) {
    if (["0", "00", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        .contains(_text)) {
      return "ANGKA";
    } else if (["+", "="].contains(_text)) {
      return "SYMBOL";
    } else if (["c"].contains(_text)) {
      return "CLEAR";
    } else {
      return "PAY";
    }
  }
}

List<String> buttons = [
  "7",
  "8",
  "9",
  "C",
  "4",
  "5",
  "6",
  "+",
  "1",
  "2",
  "3",
  "=",
  "0",
  "00",
  "Pay"
];
