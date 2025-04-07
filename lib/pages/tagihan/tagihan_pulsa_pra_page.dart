import 'package:dld/widgets/sheets/sheet_choose_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/tagihan/tagihan_pulsa_pra_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/customAppBar.dart';
import '../../widgets/components/customButton.dart';
import '../../widgets/components/customInputForm.dart';
import '../../widgets/components/text/ctext.dart';

class TagihanPulsaPraPage extends StatefulWidget {
  TagihanPulsaPraPage({Key? key}) : super(key: key);

  @override
  State<TagihanPulsaPraPage> createState() => TagihanPulsaPraPageState();
}

class TagihanPulsaPraPageState extends State<TagihanPulsaPraPage> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final TagihanPulsaPraController _controller = Get.put(
    TagihanPulsaPraController(),
    tag: 'TagihanPulsaPraController',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.pureWhite.value,
      appBar: CustomAppBar(
        context: context,
        elevation: 1,
        title: "Beli Pulsa & Data",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Obx(
          () => CustomButton(
            "Lanjutkan Pembayaran",
            width: OtherExt().getWidth(context),
            disabled: _controller.isDisabled.value,
            onPressed: () {
              FocusScope.of(context).unfocus();
              _controller.getRincian(context);
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: OtherExt().getHeight(context) - 80,
          child: Column(
            spacing: 16,
            children: [
              Container(
                color: _theme.pureBlack.value.withAlpha(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: _theme.pureWhite.value,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _theme.pureBlack.value.withAlpha(40),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomInputForm(
                            title: "Nomor HP",
                            textEditingController: _controller.noHp.value,
                            hintText: "Masukkan No HP",
                            errorMessage: "Masukkan dengan format yang benar",
                            suffixIcon: _controller.resultKode.value != ""
                                ? Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Container(
                                      width: 44,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 14,
                                      ),
                                      child: Image.asset(
                                        _controller.resultKode.value,
                                        fit: BoxFit.fitHeight,
                                        height: 16,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            onChanged: (v) {
                              _controller.findKodeFromNoHP();
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            SheetChooseContact(
                              onTap: (Contact _contact) {
                                _controller.noHp.value.text = _contact
                                    .phones.first.number
                                    .replaceAll("+62 ", "0")
                                    .replaceAll("-", "");
                                _controller.findKodeFromNoHP();
                                Get.back();
                              },
                            ),
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _theme.pureWhite.value,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/ic_contact.svg",
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _controller.choosedTab.value = "Pulsa";
                        _controller.choosedTab.refresh();
                        _controller.changeDisabled();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: _controller.choosedTab.value == "Pulsa"
                                    ? _theme.primary[4]
                                    : _theme.pureWhite.value,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Center(
                            child: CText(
                              "Pulsa",
                              color: _controller.choosedTab.value == "Pulsa"
                                  ? _theme.primary[4]
                                  : _theme.pureBlack.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _controller.choosedTab.value = "Package";
                        _controller.choosedTab.refresh();
                        _controller.changeDisabled();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: _controller.choosedTab.value == "Package"
                                    ? _theme.primary[4]
                                    : _theme.pureWhite.value,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Center(
                            child: CText(
                              "Paket Data",
                              color: _controller.choosedTab.value == "Package"
                                  ? _theme.primary[4]
                                  : _theme.pureBlack.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Expanded(
              //   child: Container(
              //     width: OtherExt().getWidth(context),
              //     color: _theme.backgroundApp.value,
              //     child: Obx(
              //       () => _controller.fetchingData.value
              //           ? Center(child: CircularProgressIndicator())
              //           : SingleChildScrollView(
              //               padding: EdgeInsets.symmetric(
              //                 horizontal: 20,
              //                 vertical: 20,
              //               ),
              //               child: Obx(
              //                 () => _controller.choosedTab.value == "Pulsa"
              //                     ? Wrap(
              //                         spacing: 10,
              //                         runSpacing: 10,
              //                         children: _controller.listPulsa.map((e) {
              //                           return GestureDetector(
              //                             onTap: () {
              //                               _controller
              //                                   .choosedDigiasiaPulsaTagihan
              //                                   .value = e;
              //                               _controller
              //                                   .choosedDigiasiaPulsaTagihan
              //                                   .refresh();
              //                               _controller.changeDisabled();
              //                             },
              //                             child: Obx(
              //                               () => Container(
              //                                 width: (OtherExt()
              //                                             .getWidth(context) -
              //                                         50) /
              //                                     2,
              //                                 decoration: BoxDecoration(
              //                                   color: _controller
              //                                               .choosedDigiasiaPulsaTagihan
              //                                               .value
              //                                               .code ==
              //                                           e.code
              //                                       ? _theme.primary[4]
              //                                       : _theme.pureWhite.value,
              //                                   borderRadius:
              //                                       BorderRadius.circular(8),
              //                                 ),
              //                                 padding: EdgeInsets.symmetric(
              //                                   horizontal: 16,
              //                                 ),
              //                                 child: Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     SizedBox(
              //                                       height: 16,
              //                                     ),
              //                                     CText(
              //                                       StringExt.thousandFormatter(
              //                                         e.nominal!,
              //                                       ),
              //                                       fontSize: 16,
              //                                       color: _controller
              //                                                   .choosedDigiasiaPulsaTagihan
              //                                                   .value
              //                                                   .code ==
              //                                               e.code
              //                                           ? _theme.pureBlack.value
              //                                           : _theme
              //                                               .pureBlack.value,
              //                                     ),
              //                                     SizedBox(
              //                                       height: 8,
              //                                     ),
              //                                     CText(
              //                                       "Harga ${StringExt.formatRupiah(
              //                                         e.price,
              //                                       )}",
              //                                       fontSize: 12,
              //                                       color: _controller
              //                                                   .choosedDigiasiaPulsaTagihan
              //                                                   .value
              //                                                   .code ==
              //                                               e.code
              //                                           ? _theme.pureBlack.value
              //                                           : _theme.success[3],
              //                                     ),
              //                                     SizedBox(
              //                                       height: 16,
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         }).toList(),
              //                       )
              //                     : Wrap(
              //                         spacing: 10,
              //                         runSpacing: 10,
              //                         children:
              //                             _controller.listPackage.map((e) {
              //                           return GestureDetector(
              //                             onTap: () {
              //                               _controller
              //                                   .choosedDigiasiaPackageTagihan
              //                                   .value = e;
              //                               _controller
              //                                   .choosedDigiasiaPackageTagihan
              //                                   .refresh();
              //                               _controller.changeDisabled();
              //                             },
              //                             child: Obx(
              //                               () => Container(
              //                                 width: (OtherExt()
              //                                         .getWidth(context) -
              //                                     50),
              //                                 decoration: BoxDecoration(
              //                                   color: _controller
              //                                               .choosedDigiasiaPackageTagihan
              //                                               .value
              //                                               .code ==
              //                                           e.code
              //                                       ? _theme.primary[4]
              //                                       : _theme.pureWhite.value,
              //                                   borderRadius:
              //                                       BorderRadius.circular(8),
              //                                 ),
              //                                 padding: EdgeInsets.symmetric(
              //                                   horizontal: 16,
              //                                 ),
              //                                 child: Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     SizedBox(
              //                                       height: 16,
              //                                     ),
              //                                     CText(
              //                                       e.name,
              //                                       fontSize: 16,
              //                                       overflow:
              //                                           TextOverflow.visible,
              //                                       lineHeight: 1.4,
              //                                       color: _controller
              //                                                   .choosedDigiasiaPackageTagihan
              //                                                   .value
              //                                                   .code ==
              //                                               e.code
              //                                           ? _theme.pureWhite.value
              //                                           : _theme
              //                                               .pureBlack.value,
              //                                     ),
              //                                     SizedBox(
              //                                       height: 8,
              //                                     ),
              //                                     CText(
              //                                       StringExt.formatRupiah(
              //                                         (e.price! + e.fee!),
              //                                       ),
              //                                       fontSize: 12,
              //                                       color: _controller
              //                                                   .choosedDigiasiaPackageTagihan
              //                                                   .value
              //                                                   .code ==
              //                                               e.code
              //                                           ? _theme.pureWhite.value
              //                                           : _theme.success[3],
              //                                     ),
              //                                     SizedBox(
              //                                       height: 16,
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           );
              //                         }).toList(),
              //                       ),
              //               ),
              //             ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
