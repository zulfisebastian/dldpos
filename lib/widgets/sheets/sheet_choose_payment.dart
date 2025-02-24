import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme/theme_controller.dart';
import '../../constants/dimension.dart';
import '../../controllers/pos/pos_controller.dart';
import '../../utils/extensions.dart';
import '../components/cdivider.dart';
import '../components/customButton.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetChoosePayment extends StatefulWidget {
  SheetChoosePayment({
    Key? key,
  }) : super(key: key);

  @override
  State<SheetChoosePayment> createState() => _SheetChoosePaymentState();
}

class _SheetChoosePaymentState extends State<SheetChoosePayment> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final PosController _posCtrl = Get.find(tag: "PosController");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: HexColor.fromHex("F5F5F5"),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DraggableBottomSheet(),
            CText(
              "Summary Transaksi",
              color: _theme.pureBlack.value,
              fontWeight: FontWeight.bold,
            ),
            Container(
              width: OtherExt().getWidth(context),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: _theme.pureWhite.value,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Total Payment",
                        color: _theme.pureBlack.value,
                      ),
                      CText(
                        "${StringExt.thousandFormatter(_posCtrl.total.value)} K",
                        color: _theme.success[2],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  CDivider(height: 1),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "Select Payment Method",
                        color: _theme.pureBlack.value,
                      ),
                      Wrap(
                        spacing: CDimension.space6,
                        runSpacing: CDimension.space16,
                        children: _posCtrl.listPayment.map((_data) {
                          return GestureDetector(
                            onTap: () {
                              _posCtrl.selectedPayment.value = _data;
                              _posCtrl.selectedPayment.refresh();
                            },
                            child: Obx(
                              () => Container(
                                width: (OtherExt().getWidth(context) - 80) / 2,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: _posCtrl.selectedPayment.value == _data
                                      ? _theme.primary[0]
                                      : Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: _theme.line.value,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: CText(
                                    _data,
                                    color: _theme.pureBlack.value,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: CustomButton(
                    "Cancel",
                    defaultColor: _theme.pureWhite.value,
                    borderColor: _theme.line.value,
                    textColor: _theme.pureBlack.value,
                    onPressed: () async {
                      Get.back();
                    },
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => CustomButton(
                      "Pay Now",
                      defaultColor: _theme.primary[4],
                      disabled: _posCtrl.selectedPayment.value == "",
                      onPressed: () async {
                        _posCtrl.submitPay();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
