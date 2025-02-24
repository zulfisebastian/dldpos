import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/pages/transaction/transaction_detail_page.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/utils/helpers.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../models/transaction/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel data;

  TransactionCard({
    super.key,
    required this.data,
  });

  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          TransactionDetailPage(data: data),
        );
        // Get.bottomSheet(
        //   SheetDetailTransaction(data: data),
        //   isScrollControlled: true,
        // );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _theme.success[1],
              ),
              padding: data.payment_method == "CASH"
                  ? EdgeInsets.all(8)
                  : EdgeInsets.all(10),
              child: SvgPicture.asset(
                data.payment_method == "CASH"
                    ? "assets/icons/ic_cash.svg"
                    : "assets/icons/ic_qr.svg",
                colorFilter: ColorFilter.mode(
                  _theme.pureWhite.value,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          CText(
                            "Pay with ${data.payment_method}",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _theme.pureBlack.value,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: getPaymentColor(data),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: CText(
                              getPaymentStringSimple(data),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _theme.pureWhite.value,
                            ),
                          ),
                        ],
                      ),
                      CText(
                        DateExt.reformat(
                          DateTime.parse(data.created_at!)
                              .add(Duration(hours: 7))
                              .toString(),
                          "yyyy-MM-dd HH:mm:ss",
                          "dd MMM yyyy HH:mm",
                        ),
                        fontSize: 10,
                        color: _theme.pureBlack.value.withAlpha(150),
                      ),
                    ],
                  ),
                  CText(
                    "${StringExt.thousandFormatter(data.total! / 1000)} K",
                    fontSize: 16,
                    color: _theme.success[2],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
