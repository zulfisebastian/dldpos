import 'package:dld/widgets/sheets/sheet_add_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme/theme_controller.dart';
import '../../constants/dimension.dart';
import '../../controllers/withdraw/withdraw_controller.dart';
import '../../utils/extensions.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetMoreAccount extends StatefulWidget {
  SheetMoreAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<SheetMoreAccount> createState() => _SheetMoreAccountState();
}

class _SheetMoreAccountState extends State<SheetMoreAccount> {
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
              "Apakah Anda Ingin Melakukan Perubahan?",
              color: _theme.pureBlack.value,
              fontWeight: FontWeight.bold,
            ),
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        SheetAddAccount(),
                        isScrollControlled: true,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: _theme.line.value,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CText(
                          "Ubah Akun",
                          color: _theme.pureBlack.value,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // _withdraw.deleteAccount();
                    },
                    child: Container(
                      width: OtherExt().getWidth(context),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _theme.error[3],
                        border: Border.all(
                          width: 1,
                          color: _theme.line.value,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CText(
                          "Hapus Akun",
                          color: _theme.pureWhite.value,
                        ),
                      ),
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
