import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/tagihan/tagihan_pulsa_post_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/customAppBar.dart';
import '../../widgets/components/customInputForm.dart';
import '../../widgets/components/text/ctext.dart';

class TagihanListrikTokenPage extends StatefulWidget {
  TagihanListrikTokenPage({Key? key}) : super(key: key);

  @override
  State<TagihanListrikTokenPage> createState() =>
      TagihanListrikTokenPageState();
}

class TagihanListrikTokenPageState extends State<TagihanListrikTokenPage> {
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
        title: "Beli Token Listrik",
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
                  child: Column(
                    spacing: 10,
                    children: [
                      CustomInputForm(
                        title: "Nomor Meter",
                        textEditingController: _controller.noHp.value,
                        hintText: "Masukkan Nomor Meter",
                        errorMessage: "Masukkan dengan format yang benar",
                        onChanged: (v) {
                          //
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: _theme.warning[0],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Column(
                          spacing: 8,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                CText(
                                  "Information",
                                  color: _theme.pureBlack.value,
                                ),
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: _theme.warning[2],
                                ),
                              ],
                            ),
                            CText(
                              "Biar pembayaran berhasil, cek dulu batas dayanya ya — caranya gampang: tinggal kalikan daya dari grup energi (dalam kilowatt) x 720 jam x harga per kWh.",
                              fontSize: 12,
                              overflow: TextOverflow.visible,
                              color: _theme.pureBlack.value.withAlpha(120),
                            ),
                          ],
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
