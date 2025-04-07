import 'package:dld/controllers/withdraw/withdraw_controller.dart';
import 'package:dld/widgets/components/cdivider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme/theme_controller.dart';
import '../components/draggable_bottom_sheet.dart';
import '../components/text/ctext.dart';

class SheetChooseBank extends StatelessWidget {
  SheetChooseBank({
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
                CText(
                  "Pilih Bank",
                  fontSize: 16,
                  color: _theme.pureBlack.value,
                ),
                ListView.separated(
                  itemCount: _withdraw.listBank.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CDivider(height: 1),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var _data = _withdraw.listBank[index];
                    return GestureDetector(
                      onTap: () {
                        _withdraw.selectedBank.value = _data;
                        _withdraw.addBank.value.text = _data.name!;
                        Get.back();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => CText(
                                _data.name,
                                fontSize: 16,
                                color: _withdraw.selectedBank.value.code ==
                                        _data.code
                                    ? _theme.success[2]
                                    : _theme.pureBlack.value,
                              ),
                            ),
                          ),
                          if (_withdraw.selectedBank.value.code == _data.code)
                            Icon(
                              Icons.check_circle,
                              color: _theme.success[2],
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
      },
    );
  }
}
