import 'package:dld/controllers/withdraw/withdraw_controller.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/theme/theme_controller.dart';
import '../../widgets/components/cdivider.dart';
import '../../widgets/components/text/ctext.dart';

class WithdrawHistoryPage extends StatelessWidget {
  final WithdrawController _withdraw = Get.find(tag: "WithdrawController");
  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    // Ini cuma contoh simple
    return Scaffold(
      backgroundColor: _theme.pureWhite.value,
      appBar: CustomAppBar(
        context: context,
        title: "Riwayat Penarikan",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _withdraw.listWithdraw.length,
              separatorBuilder: (context, index) {
                return CDivider(
                  height: 1,
                );
              },
              itemBuilder: (context, index) {
                var _data = _withdraw.listWithdraw[index];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        DateExt.reformat(
                          _data.initiated_at!,
                          "yyyy-MM-dd HH:mm:ss",
                          "EEE, dd MMM yyyy - HH:mm",
                        ),
                        color: _theme.pureBlack.value.withAlpha(140),
                      ),
                      // Header (Bank Name & Status)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            _data.bank_name!,
                            color: _theme.pureBlack.value,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _data.status == 'pending'
                                  ? Colors.orange
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CText(
                              _data.status!.toUpperCase(),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Bank Account Details
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama Pemilik",
                                  style: TextStyle(color: Colors.grey)),
                              Text(_data.bank_account_name!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 12,
                              ),
                              Text("No. Rekening",
                                  style: TextStyle(color: Colors.grey)),
                              Text(
                                _data.bank_account_number!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          CText(
                            StringExt.formatRupiah(_data.amount, "Rp. ", ""),
                            fontSize: 20,
                            color: _theme.primary[4],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
