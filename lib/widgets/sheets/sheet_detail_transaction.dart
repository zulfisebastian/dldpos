import 'dart:async';

import 'package:dld/utils/extensions.dart';
import 'package:dld/utils/helpers.dart';
import 'package:dld/widgets/components/cdivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../models/transaction/transaction_model.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetDetailTransaction extends StatefulWidget {
  final TransactionModel data;

  SheetDetailTransaction({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<SheetDetailTransaction> createState() => _SheetDetailTransactionState();
}

class _SheetDetailTransactionState extends State<SheetDetailTransaction> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  late DateTime targetDate;
  Duration remainingTime = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    targetDate = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(widget.data.invoice!.expired_in!);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        remainingTime = targetDate.difference(now);
        if (remainingTime.isNegative) {
          timer.cancel(); // Stop timer kalau waktu habis
          remainingTime = Duration.zero;
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    return '$days Hari $hours Jam $minutes Menit $seconds Detik';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DraggableBottomSheet(),
            CText(
              "Detail Transaksi",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              lineHeight: 1.5,
              overflow: TextOverflow.visible,
              color: _theme.pureBlack.value,
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
                    spacing: 8,
                    children: [
                      CText(
                        "Transaction number",
                        fontSize: 12,
                        color: _theme.pureBlack.value.withAlpha(120),
                      ),
                      Row(
                        children: [
                          CText(
                            "#",
                            fontSize: 12,
                            color: _theme.pureBlack.value.withAlpha(120),
                          ),
                          CText(
                            "${widget.data.number}",
                            fontSize: 12,
                            color: _theme.pureBlack.value,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CDivider(height: 1),
                  Column(
                    spacing: 16,
                    children: [
                      if (!DateExt.checkIsExpired(
                          widget.data.invoice!.expired_in!))
                        if (widget.data.payment_status! == "pending")
                          Container(
                            width: 300,
                            height: 300,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: _theme.line.value,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.data.invoice!.local_qr_url!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      SvgPicture.asset(
                        DateExt.checkIsExpired(widget.data.invoice!.expired_in!)
                            ? "assets/icons/ic_failed.svg"
                            : widget.data.payment_status! == "pending"
                                ? "assets/icons/ic_pending.svg"
                                : widget.data.payment_status! == "success"
                                    ? "assets/icons/ic_success.svg"
                                    : "assets/icons/ic_failed.svg",
                        height: 60,
                        width: 60,
                        colorFilter: ColorFilter.mode(
                          getPaymentColor(widget.data),
                          BlendMode.srcIn,
                        ),
                      ),
                      CText(
                        DateExt.checkIsExpired(widget.data.invoice!.expired_in!)
                            ? "Pembayaran Expired"
                            : widget.data.payment_status! == "pending"
                                ? "Menunggu Pembayaran"
                                : widget.data.payment_status! == "success"
                                    ? "Pembayaran Berhasil"
                                    : "Pembayaran Gagal",
                        fontSize: 12,
                        color: _theme.pureBlack.value,
                      ),
                    ],
                  ),
                  CDivider(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Date",
                        color: _theme.pureBlack.value.withAlpha(120),
                      ),
                      CText(
                        DateExt.reformat(widget.data.created_at!,
                            "yyyy-MM-ddTHH:mm:ss", "EEE, dd MMM yyyy"),
                        color: _theme.pureBlack.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Time",
                        color: _theme.pureBlack.value.withAlpha(120),
                      ),
                      CText(
                        DateExt.reformat(widget.data.created_at!,
                            "yyyy-MM-ddTHH:mm:ss", "HH:mm:ss"),
                        color: _theme.pureBlack.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Payment Method",
                        color: _theme.pureBlack.value.withAlpha(120),
                      ),
                      CText(
                        widget.data.payment_method,
                        color: _theme.pureBlack.value,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Payment Status",
                        color: _theme.pureBlack.value.withAlpha(120),
                      ),
                      CText(
                        DateExt.checkIsExpired(widget.data.invoice!.expired_in!)
                            ? "EXPIRED"
                            : (widget.data.payment_status ?? "pending")
                                .toUpperCase(),
                        color: getPaymentColor(widget.data),
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Total Payment",
                        color: _theme.pureBlack.value.withAlpha(120),
                      ),
                      CText(
                        "${StringExt.thousandFormatter(widget.data.total! / 1000)} K",
                        color: _theme.success[2],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
