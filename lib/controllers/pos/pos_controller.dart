import 'package:dld/models/transaction/transaction_model.dart';
import 'package:dld/pages/home/home_page.dart';
import 'package:dld/pages/transaction/transaction_detail_page.dart';
import 'package:dld/repository/transaction/transaction_repo.dart';
import 'package:dld/widgets/components/ctoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/global/payment_model.dart';
import '../../repository/global/global_repo.dart';
import '../../widgets/pages/loading.dart';

class PosController extends GetxController {
  final TransactionRepo _transactionRepo = TransactionRepo();
  final GlobalRepo _globalRepo = GlobalRepo();

  @override
  void onReady() {
    super.onReady();
    getAllData();
  }

  getAllData() async {
    Get.dialog(
      Loading(),
      barrierDismissible: false,
    );
    await getListPayment();
    Get.back();
  }

  RxInt total = 0.obs;

  RxList<String> listPayment = <String>[].obs;
  Rx<String> selectedPayment = "".obs;
  getListPayment() async {
    PaymentListResponse _resp = await _globalRepo.getPayment();

    if (!_resp.error!) {
      listPayment.value = _resp.data!;
      listPayment.refresh();
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        Colors.red,
        Colors.white,
      );
    }
  }

  submitPay() async {
    Get.dialog(Loading());
    var body = {
      "total": total.value * 1000,
      "payment_method": selectedPayment.value,
    };

    TransactionResponse _resp = await _transactionRepo.postTransaction(body);
    Get.back();

    if (!_resp.error!) {
      Get.off(HomePage());
      CToast.showWithoutCOntext(
        "Transaction Success",
        Colors.green,
        Colors.white,
      );
      if (_resp.data!.payment_method == "QRIS") {
        Get.to(TransactionDetailPage(data: _resp.data!));
      }
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        Colors.red,
        Colors.white,
      );
    }
  }
}
