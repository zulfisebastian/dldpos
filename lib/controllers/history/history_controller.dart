import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dld/repository/global/global_repo.dart';
import '../../models/transaction/transaction_model.dart';
import '../../repository/transaction/transaction_repo.dart';

class HistoryController extends GetxController {
  final scrollController = ScrollController();

  Rx<TextEditingController> searchController = TextEditingController().obs;
  final GlobalRepo _globalRepo = GlobalRepo();
  final TransactionRepo _transactionRepo = TransactionRepo();

  @override
  void onReady() {
    super.onReady();
    getListTransaction();
  }

  RxList<TransactionModel> transactions = RxList<TransactionModel>();
  getListTransaction() async {
    var body = {};

    TransactionListResponse _resp =
        await _transactionRepo.getTransactions(body);

    if (_resp.status == 200) {
      transactions.value = _resp.data!.results!;
      transactions.refresh();
    } else {
      transactions.clear();
      // CToast.showWithoutCOntext(message, color, textcolor);
    }
  }
}
