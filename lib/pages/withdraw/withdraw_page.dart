import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/pages/withdraw/withdraw_history_page.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/customAppBar.dart';
import 'package:dld/widgets/components/customInputForm.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/withdraw/withdraw_controller.dart';
import '../../widgets/components/customButton.dart';
import '../../widgets/sheets/sheet_choose_account.dart';

class WithdrawPage extends StatelessWidget {
  final _withdraw = Get.put(WithdrawController(), tag: "WithdrawController");

  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: "Tarik Dana",
        action: IconButton(
          icon: Icon(
            Icons.history,
            color: _theme.pureBlack.value,
          ),
          onPressed: () {
            Get.to(WithdrawHistoryPage());
          },
        ),
      ),
      bottomSheet: Material(
        elevation: 20,
        child: MediaQuery.of(context).viewInsets.bottom == 0
            ? Container(
                width: OtherExt().getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Obx(
                  () => CustomButton(
                    "Tarik Dana",
                    textColor: _theme.pureWhite.value,
                    defaultColor: _theme.primary[4],
                    borderColor: _theme.line.value,
                    disabled: _withdraw.selectedAccount.value == "" ||
                        _withdraw.nominal.value <= 0,
                    onPressed: () {
                      _withdraw.submitWithdraw();
                    },
                  ),
                ),
              )
            : SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _theme.pureWhite.value,
                boxShadow: [
                  BoxShadow(
                    color: _theme.line.value,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    "Saldo Anda: ",
                    color: _theme.pureBlack.value,
                  ),
                  Obx(
                    () => CText(
                      "${StringExt.formatRupiah(_withdraw.withdrawBalance.value.amount ?? 0, "Rp. ", "")}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _theme.primary[4],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Tentukan Jumlah Penarikan",
                    color: _theme.pureBlack.value,
                  ),
                  CustomInputForm(
                    textEditingController: _withdraw.nominalController.value,
                    title: "",
                    hintText: "",
                    errorMessage: "",
                    onChanged: (v) {
                      var nominal = double.parse(v.toString());
                      if (nominal >
                          _withdraw.withdrawBalance.value.amount!.toDouble()) {
                        _withdraw.nominal.value =
                            _withdraw.withdrawBalance.value.amount!.toInt();
                      } else {
                        _withdraw.nominal.value = nominal.toInt();
                      }
                    },
                  ),
                  Obx(
                    () => Slider(
                      value: _withdraw.nominal.value.toDouble(),
                      min: 0,
                      max: _withdraw.withdrawBalance.value.amount!.toDouble(),
                      onChanged: (value) {
                        _withdraw.nominal.value = value.toInt();
                        _withdraw.nominalController.value.text =
                            _withdraw.nominal.value.toString();
                      },
                      divisions: 100,
                      thumbColor: _theme.success[2],
                      activeColor: _theme.success[2],
                    ),
                  ),
                  Center(
                    child: Obx(
                      () => CText(
                        "Nominal: ${StringExt.formatRupiah(_withdraw.nominal.value, "Rp. ", "")}",
                        color: _theme.pureBlack.value,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CText(
                    "Pilih Akun Bank",
                    color: _theme.pureBlack.value,
                  ),
                  CText(
                    "Bank ini akan digunakan untuk penarikan dana",
                    fontSize: 12,
                    color: _theme.pureBlack.value.withAlpha(120),
                  ),
                  SizedBox(height: 12),
                  Obx(
                    () => _withdraw.selectedAccount.value.id == null
                        ? CustomButton(
                            "Pilih Akun Bank",
                            borderColor: _theme.line.value,
                            textColor: _theme.pureBlack.value,
                            onPressed: () {
                              Get.bottomSheet(
                                SheetChooseAccount(),
                                isScrollControlled: true,
                              );
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: _theme.pureWhite.value,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _theme.line.value,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 5,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => CText(
                                          _withdraw.selectedAccount.value
                                              .account_name,
                                          fontSize: 16,
                                          color: _theme.pureBlack.value,
                                        ),
                                      ),
                                      Obx(
                                        () => CText(
                                          "${_withdraw.selectedAccount.value.account_number} | ${_withdraw.selectedAccount.value.name}",
                                          spacing: 1.5,
                                          color: _theme.pureBlack.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      SheetChooseAccount(),
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: Icon(
                                    Icons.change_circle_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
