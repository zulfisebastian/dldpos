import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../controllers/transaction/transaction_detail_controller.dart';
import '../../models/transaction/transaction_model.dart';
import '../../utils/extensions.dart';
import '../../utils/helpers.dart';
import '../../widgets/components/customAppBar.dart';
import '../../widgets/components/customButton.dart';
import '../../widgets/components/cdivider.dart';
import '../../widgets/components/text/ctext.dart';

class TransactionDetailPage extends StatefulWidget {
  final TransactionModel data;

  const TransactionDetailPage({super.key, required this.data});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final ThemeController _theme = Get.find(tag: "ThemeController");
  final TransactionDetailController _ctrl = Get.put(
    TransactionDetailController(),
    tag: "TransactionDetailController",
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _ctrl.startCheck(widget.data),
    );
  }

  @override
  void dispose() {
    Get.delete<TransactionDetailController>(tag: "TransactionDetailController");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor.fromHex("F5F5F5"),
        appBar: CustomAppBar(context: context, title: "Transaction Detail"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: _theme.pureWhite.value,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: _theme.line.value,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  spacing: 16,
                  children: [
                    // Transaction Number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText("Transaction number",
                            fontSize: 12,
                            color: _theme.pureBlack.value.withAlpha(120)),
                        CText("#${widget.data.number}",
                            fontSize: 12,
                            color: _theme.pureBlack.value,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    CDivider(height: 1),

                    // Payment Status Section
                    Obx(() {
                      final transaction = _ctrl.transaction.value;
                      final isExpired = transaction.invoice == null ||
                          DateExt.checkIsExpired(
                              transaction.invoice!.expired_in!);
                      final isPending = transaction.payment_status == "pending";

                      if (isExpired || !isPending) return SizedBox.shrink();

                      String formattedTime = [
                        _ctrl.duration.value.inHours % 24,
                        _ctrl.duration.value.inMinutes % 60,
                        _ctrl.duration.value.inSeconds % 60
                      ].map((e) => e.toString().padLeft(2, '0')).join(":");

                      return Column(
                        spacing: 16,
                        children: [
                          CText(
                            _ctrl.duration.value.isNegative
                                ? "Waktu Habis!"
                                : formattedTime,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _theme.pureBlack.value,
                          ),
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: _theme.line.value),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    transaction.invoice!.local_qr_url!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    // Payment Icon & Status
                    Obx(() {
                      final transaction = _ctrl.transaction.value;
                      final paymentIcon = getPaymentIcon(transaction);
                      final paymentColor = getPaymentColor(transaction);
                      final paymentStatus = getPaymentString(transaction);

                      return Column(
                        spacing: 16,
                        children: [
                          SvgPicture.asset(
                            paymentIcon,
                            height: 60,
                            width: 60,
                            colorFilter: ColorFilter.mode(
                              paymentColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          CText(
                            paymentStatus,
                            fontSize: 12,
                            color: _theme.pureBlack.value,
                          ),
                        ],
                      );
                    }),

                    // Check Status Button
                    Obx(() {
                      final transaction = _ctrl.transaction.value;
                      if (transaction.invoice == null ||
                          DateExt.checkIsExpired(
                              transaction.invoice!.expired_in!) ||
                          transaction.payment_status != "pending") {
                        return SizedBox.shrink();
                      }

                      return Column(
                        spacing: 16,
                        children: [
                          CDivider(height: 1),
                          CustomButton(
                            "CEK STATUS",
                            width: 180,
                            height: 32,
                            paddingVertical: 0,
                            defaultColor: _theme.primary[3],
                            onPressed: () =>
                                _ctrl.getDataTransaction(widget.data.number!),
                          ),
                        ],
                      );
                    }),

                    // Transaction Info
                    CDivider(height: 1),
                    _buildTransactionInfo(
                      "Date",
                      DateExt.reformat(widget.data.created_at!,
                          "yyyy-MM-ddTHH:mm:ss", "EEE, dd MMM yyyy"),
                    ),
                    _buildTransactionInfo(
                      "Time",
                      DateExt.reformat(widget.data.created_at!,
                          "yyyy-MM-ddTHH:mm:ss", "HH:mm:ss"),
                    ),
                    _buildTransactionInfo(
                      "Payment Method",
                      widget.data.payment_method!,
                    ),
                    _buildPaymentStatus(),
                    _buildTransactionInfo(
                      "Total Payment",
                      "${StringExt.thousandFormatter(widget.data.total! / 1000)} K",
                      color: _theme.success[2],
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionInfo(String title, String value,
      {Color? color, double fontSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(title, color: _theme.pureBlack.value.withAlpha(120)),
        CText(value,
            color: color ?? _theme.pureBlack.value,
            fontWeight: FontWeight.bold,
            fontSize: fontSize),
      ],
    );
  }

  Widget _buildPaymentStatus() {
    return Obx(() {
      final transaction = _ctrl.transaction.value;
      final paymentStatus = getPaymentString(transaction);
      final paymentColor = getPaymentColor(transaction);

      return _buildTransactionInfo("Payment Status", paymentStatus,
          color: paymentColor);
    });
  }
}
