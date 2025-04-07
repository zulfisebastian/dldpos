import 'package:dld/controllers/withdraw/withdraw_controller.dart';
import 'package:dld/widgets/components/cdivider.dart';
import 'package:dld/widgets/components/customButton.dart';
import 'package:dld/widgets/sheets/sheet_more_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';
import 'sheet_add_account.dart';

class SheetChooseAccount extends StatelessWidget {
  SheetChooseAccount({
    Key? key,
  }) : super(key: key);

  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final WithdrawController _withdraw = Get.find(tag: 'WithdrawController');

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      snap: true,
      initialChildSize: 0.85,
      minChildSize: 0.85,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: _theme.pureWhite.value,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DraggableBottomSheet(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      "Pilih Akun Bank",
                      fontSize: 16,
                      color: _theme.pureBlack.value,
                    ),
                    CustomButton(
                      "Tambah Baru",
                      textColor: _theme.pureBlack.value,
                      borderColor: _theme.pureBlack.value.withAlpha(80),
                      icon: Icon(
                        Icons.add_circle_outline_rounded,
                        color: _theme.success[3],
                        size: 20,
                      ),
                      onPressed: () async {
                        await Get.bottomSheet(
                          SheetAddAccount(),
                          isScrollControlled: true,
                        );
                        Get.back();
                      },
                    ),
                  ],
                ),
                ListView.separated(
                  itemCount: _withdraw.listAccount.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CDivider(height: 1),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var _data = _withdraw.listAccount[index];
                    return Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _withdraw.selectedAccount.value = _data;
                              Get.back();
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => CText(
                                        _data.account_name,
                                        fontSize: 16,
                                        color: _withdraw
                                                    .selectedAccount.value.id ==
                                                _data.id
                                            ? _theme.success[2]
                                            : _theme.pureBlack.value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (_withdraw.selectedAccount.value.id ==
                                        _data.id)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: _theme.success[2],
                                          size: 16,
                                        ),
                                      ),
                                  ],
                                ),
                                CText(
                                  "${_data.account_number}  |  ${_data.name}",
                                  spacing: 1.5,
                                  color: _theme.pureBlack.value,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.bottomSheet(
                        //       SheetMoreAccount(),
                        //       isScrollControlled: true,
                        //     );
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 20,
                        //     ),
                        //     child: Icon(
                        //       Icons.more_vert_rounded,
                        //       size: 20,
                        //     ),
                        //   ),
                        // )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
