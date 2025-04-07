import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/tagihan/tagihan_pulsa_post_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/customAppBar.dart';
import '../../widgets/components/customInputForm.dart';

class TagihanListrikPostPage extends StatefulWidget {
  TagihanListrikPostPage({Key? key}) : super(key: key);

  @override
  State<TagihanListrikPostPage> createState() => TagihanListrikPostPageState();
}

class TagihanListrikPostPageState extends State<TagihanListrikPostPage> {
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
        title: "Bayar Tagihan Listrik",
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
                    children: [
                      CustomInputForm(
                        title: "Customer ID",
                        textEditingController: _controller.noHp.value,
                        hintText: "Masukkan Customer ID",
                        errorMessage: "Masukkan dengan format yang benar",
                        onChanged: (v) {
                          //
                        },
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
