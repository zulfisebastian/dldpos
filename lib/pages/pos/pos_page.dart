import 'package:dld/controllers/pos/pos_controller.dart';
import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/customAppBar.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import 'package:dld/widgets/sheets/sheet_choose_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosPage extends StatefulWidget {
  @override
  _PosPageState createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  String inputString = "";
  String input = "";
  bool isNewInput = true;
  bool isFinish = false;

  void onButtonPressed(String value) {
    setState(() {
      if (value == "c") {
        input = "";
        inputString = "";
        _posCtrl.total.value = 0;
        isFinish = false;
        isNewInput = true;
      } else if (value == "+") {
        if (input.isNotEmpty) {
          inputString += value;
          isFinish = false;
          print(input);
          if (!isNewInput) {
            _posCtrl.total.value += int.parse(input);
          }
          input = "";
          isNewInput = false;
        }
      } else if (value == "=") {
        if (isNewInput) return;
        inputString += value;
        if (input.isNotEmpty) {
          _posCtrl.total.value += int.parse(input);
          input = "0";
        }
        inputString += _posCtrl.total.value.toString();
        input = _posCtrl.total.value.toString();
        isFinish = true;
        isNewInput = true;
      } else {
        if (input == "" && value == "0") return;
        if (input == "" && value == "00") return;
        if (isNewInput) {
          inputString += value;
          input = value;
          isNewInput = false;
        } else {
          inputString += value;
          isFinish = false;
          input += value;
        }
      }
    });
  }

  final ThemeController _theme = Get.find(tag: "ThemeController");
  final PosController _posCtrl = Get.put(PosController(), tag: "PosController");

  @override
  void dispose() {
    super.dispose();
    Get.delete<PosController>(tag: "PosController");
  }

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
                    "${StringExt.thousandFormatter(_posCtrl.total.value)}",
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
                        POSButton(
                          text: "7",
                          onTap: () => onButtonPressed("7"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "8",
                          onTap: () => onButtonPressed("8"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "9",
                          onTap: () => onButtonPressed("9"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "c",
                          onTap: () => onButtonPressed("c"),
                          isFinish: isFinish,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(
                          text: "4",
                          onTap: () => onButtonPressed("4"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "5",
                          onTap: () => onButtonPressed("5"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "6",
                          onTap: () => onButtonPressed("6"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "+",
                          onTap: () => onButtonPressed("+"),
                          isFinish: isFinish,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(
                          text: "1",
                          onTap: () => onButtonPressed("1"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "2",
                          onTap: () => onButtonPressed("2"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "3",
                          onTap: () => onButtonPressed("3"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "=",
                          onTap: () => onButtonPressed("="),
                          isFinish: isFinish,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        POSButton(
                          text: "0",
                          onTap: () => onButtonPressed("0"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "00",
                          onTap: () => onButtonPressed("00"),
                          isFinish: isFinish,
                        ),
                        POSButton(
                          text: "Pay",
                          onTap: () => {
                            Get.bottomSheet(
                              SheetChoosePayment(),
                              isScrollControlled: true,
                            )
                          },
                          flex: 2,
                          isFinish: isFinish,
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
  final bool isFinish;

  POSButton({
    required this.text,
    required this.onTap,
    required this.isFinish,
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
                          : isFinish
                              ? _theme.primary[4]
                              : _theme.disabled.value,
            ),
            color: checkTextType(text) == "ANGKA"
                ? HexColor.fromHex("262626").withAlpha(220)
                : checkTextType(text) == "SYMBOL"
                    ? HexColor.fromHex("8CCE82").withAlpha(220)
                    : checkTextType(text) == "CLEAR"
                        ? HexColor.fromHex("E84A57").withAlpha(220)
                        : isFinish
                            ? _theme.primary[4]
                            : _theme.disabled.value,
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
