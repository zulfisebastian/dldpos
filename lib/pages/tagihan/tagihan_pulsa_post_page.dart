import 'package:dld/widgets/sheets/sheet_choose_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/tagihan/tagihan_pulsa_post_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/customAppBar.dart';
import '../../widgets/components/customInputForm.dart';

class TagihanPulsaPostPage extends StatefulWidget {
  TagihanPulsaPostPage({Key? key}) : super(key: key);

  @override
  State<TagihanPulsaPostPage> createState() => TagihanPulsaPostPageState();
}

class TagihanPulsaPostPageState extends State<TagihanPulsaPostPage> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final TagihanPulsaPostController _controller = Get.put(
    TagihanPulsaPostController(),
    tag: 'TagihanPulsaPostController',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.pureWhite.value,
      appBar: CustomAppBar(
        context: context,
        elevation: 1,
        title: "Bayar Tagihan Pulsa",
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
            ],
          ),
        ),
      ),
    );
  }
}
