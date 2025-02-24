import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/card/transaction_card.dart';
import 'package:dld/widgets/components/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transaction/transaction_controller.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final ThemeController _theme = Get.find(tag: "ThemeController");
  final TransactionController _controller =
      Get.put(TransactionController(), tag: "HistoryController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.pureWhite.value,
      appBar: CustomAppBar(
        context: context,
        title: "History",
      ),
      body: Container(
        width: OtherExt().getWidth(context),
        height: OtherExt().getHeight(context),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Obx(
                () => ListView.separated(
                  itemCount: _controller.listHistory.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var _data = _controller.listHistory[index];
                    return TransactionCard(data: _data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
