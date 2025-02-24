import 'dart:async';

import 'package:dld/repository/transaction/transaction_repo.dart';
import 'package:dld/widgets/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../models/transaction/transaction_model.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/ctoast.dart';

class TransactionDetailController extends GetxController {
  final TransactionRepo _trxRepo = Get.put(TransactionRepo());

  Timer? timer;
  Timer? timerExpired;
  Rx<Duration> duration = Duration.zero.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    timer?.cancel();
    timerExpired?.cancel();
    super.dispose();
  }

  startCheck(TransactionModel data) {
    getDataTransaction(data.number!);
    if (data.invoice != null &&
        !DateExt.checkIsExpired(data.invoice!.expired_in!) &&
        data.payment_status == "pending")
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        getDataTransaction(data.number!);
      });
  }

  Rx<TransactionModel> transaction = TransactionModel().obs;
  getDataTransaction(String id, [bool showLoading = false]) async {
    if (showLoading) Get.dialog(Loading());

    TransactionResponse _resp = await _trxRepo.getTransactionById(id);

    if (_resp.data != null) {
      transaction.value = _resp.data!;
      transaction.refresh();
      if (transaction.value.payment_status == "pending") startTimer();
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        Colors.red,
        Colors.white,
        ToastGravity.TOP,
      );
    }
  }

  void startTimer() {
    timerExpired = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime targetDate =
          DateTime.parse(transaction.value.invoice!.expired_in!)
              .add(Duration(hours: 7));
      duration.value = targetDate.difference(DateTime.now());
      if (duration.value.isNegative) {
        timerExpired?.cancel();
      }
    });
  }
}
