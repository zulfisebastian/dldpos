import 'package:dld/controllers/withdraw/withdraw_controller.dart';
import 'package:dld/widgets/components/customButton.dart';
import 'package:dld/widgets/components/customInputForm.dart';
import 'package:dld/widgets/sheets/sheet_choose_bank.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetAddAccount extends StatelessWidget {
  SheetAddAccount({
    Key? key,
  }) : super(key: key);

  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final WithdrawController _withdraw = Get.find(tag: 'WithdrawController');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: _theme.pureWhite.value,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DraggableBottomSheet(),
            CText(
              "Tambah Akun Bank",
              color: _theme.pureBlack.value,
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Get.bottomSheet(
                  SheetChooseBank(),
                  isScrollControlled: true,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: AbsorbPointer(
                absorbing: true,
                child: CustomInputForm(
                  title: "",
                  textEditingController: _withdraw.addBank.value,
                  hintText: "Pilih Bank",
                  errorMessage: "",
                  keyboardType: TextInputType.name,
                  onChanged: (v) {
                    //
                  },
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _theme.pureBlack.value,
                  ),
                ),
              ),
            ),
            CustomInputForm(
              textEditingController: _withdraw.addAccountName.value,
              title: "Nama Akun Bank",
              hintText: "Masukkan Nama Akun (Contoh: John Doe)",
              errorMessage: "",
              onChanged: (v) {
                //
              },
            ),
            CustomInputForm(
              textEditingController: _withdraw.addAccountNumber.value,
              title: "Nomor Akun Bank",
              hintText: "Masukkan Nomor Akun",
              errorMessage: "",
              keyboardType: TextInputType.number,
              onChanged: (v) {
                //
              },
            ),
            CustomButton(
              "Simpan Akun",
              defaultColor: _theme.primary[3],
              onPressed: () {
                _withdraw.addNewBank();
              },
            ),
          ],
        ),
      ),
    );
  }
}
