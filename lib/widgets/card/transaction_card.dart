import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/utils/extensions.dart';
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
        //
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
                color:
                    data.type == "income" ? _theme.success[1] : _theme.error[1],
              ),
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset(
                data.type == "income"
                    ? "assets/icons/ic_in.svg"
                    : "assets/icons/ic_out.svg",
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
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          CText(
                            "${data.type == "income" ? "Pay" : "Withdraw"}",
                            color: _theme.pureBlack.value,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _theme.primary[3],
                            ),
                            padding: EdgeInsets.all(4),
                            child: CText(
                              data.payment,
                              fontSize: 11,
                              color: _theme.pureWhite.value,
                            ),
                          ),
                        ],
                      ),
                      CText(
                        DateExt.reformat(
                          data.date!,
                          "yyyy-MM-dd HH:mm:ss",
                          "dd MMM yyyy HH:mm",
                        ),
                        fontSize: 11,
                        color: _theme.pureBlack.value.withAlpha(150),
                      ),
                    ],
                  ),
                  CText(
                    "${data.type == "income" ? "+" : "-"} ${StringExt.thousandFormatter(data.value)} K",
                    fontSize: 16,
                    color: data.type == "income"
                        ? _theme.success[3]
                        : _theme.error[3],
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
