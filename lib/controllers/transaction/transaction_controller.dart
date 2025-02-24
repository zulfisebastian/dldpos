import 'package:dld/repository/transaction/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../models/transaction/transaction_model.dart';
import '../../widgets/components/ctoast.dart';

class TransactionController extends GetxController {
  final scrollController = ScrollController();
  Rx<TextEditingController> search = TextEditingController().obs;

  final TransactionRepo _trxRepo = Get.put(TransactionRepo());

  RxString choosedCategory = "All".obs;

  @override
  void onReady() {
    super.onReady();
    initAllData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initAllData() {
    getDataTransaction();
  }

  RxList<TransactionModel> listHistory = <TransactionModel>[].obs;
  getDataTransaction() async {
    var body = {
      "per_page": 10000,
    };

    TransactionListResponse _resp = await _trxRepo.getTransactions(body);

    if (_resp.data != null) {
      listHistory.value = _resp.data!;
      listHistory.refresh();
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        Colors.red,
        Colors.white,
        ToastGravity.TOP,
      );
    }
  }
}
