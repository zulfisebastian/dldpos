import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:dld/models/account/account_model.dart';
import 'package:dld/models/global/balance_model.dart';
import 'package:dld/models/global/withdraw_model.dart';
import 'package:dld/repository/withdraw/withdraw_repo.dart';
import 'package:dld/widgets/components/ctoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/global/bank_model.dart';
import '../../widgets/pages/loading.dart';

class WithdrawController extends GetxController {
  final ThemeController _theme = Get.find(tag: "ThemeController");
  final WithdrawRepo _withdrawRepo = Get.put(WithdrawRepo());

  Rx<TextEditingController> addBank = TextEditingController().obs;
  Rx<TextEditingController> addAccountName = TextEditingController().obs;
  Rx<TextEditingController> addAccountNumber = TextEditingController().obs;

  RxInt nominal = 0.obs;
  Rx<TextEditingController> nominalController = TextEditingController().obs;
  Rx<BalanceModel> withdrawBalance = BalanceModel().obs;
  RxList<BankModel> listBank = <BankModel>[].obs;
  Rx<BankModel> selectedBank = BankModel().obs;
  RxList<AccountModel> listAccount = <AccountModel>[].obs;
  Rx<AccountModel> selectedAccount = AccountModel().obs;

  RxList<WithdrawModel> listWithdraw = <WithdrawModel>[].obs;

  @override
  void onReady() {
    getAllData();
    super.onReady();
  }

  getAllData() async {
    Get.dialog(Loading());
    getBalance();
    getHistory();
    getListBank();
    getAccountList();
    Get.back();
  }

  getBalance() async {
    var _resp = await _withdrawRepo.getBalanceWithdraw();
    if (!_resp.error!) {
      withdrawBalance.value = _resp.data!;
    }
  }

  getHistory() async {
    var _resp = await _withdrawRepo.getListWithdraw();
    if (!_resp.error!) {
      listWithdraw.value = _resp.data!;
    }
  }

  getListBank() async {
    var _resp = await _withdrawRepo.getBank();
    if (!_resp.error!) {
      listBank.value = _resp.data!;
    }
  }

  getAccountList() async {
    var _resp = await _withdrawRepo.getMyAccount();
    if (!_resp.error!) {
      listAccount.value = _resp.data!;
    }
  }

  addNewBank() async {
    var body = {
      "bank_code": selectedBank.value.code,
      "name": selectedBank.value.name,
      "account_name": addAccountName.value.text,
      "account_number": addAccountNumber.value.text,
    };

    var _resp = await _withdrawRepo.createAccount(body);

    if (!_resp.error!) {
      CToast.showWithoutCOntext(
        "Sukses Menambah Akun",
        _theme.success[3],
        _theme.pureWhite.value,
      );
      getAccountList();
    }
  }

  updateBank() async {
    var body = {
      "bank_code": selectedBank.value.code,
      "name": selectedBank.value.name,
      "account_name": addAccountName.value.text,
      "account_number": addAccountNumber.value.text,
    };

    var _resp = await _withdrawRepo.createAccount(body);

    if (!_resp.error!) {
      CToast.showWithoutCOntext(
        "Sukses Menambah Akun",
        _theme.success[3],
        _theme.pureWhite.value,
      );
      getAccountList();
    }
  }

  void submitWithdraw() async {
    if (nominal.value <= 0 || selectedAccount.value.id == null) {
      CToast.showWithoutCOntext(
        "Nominal dan Bank harus diisi",
        _theme.error[3],
        _theme.pureWhite.value,
      );
      return;
    }

    var body = {
      "amount": nominal.value,
      "bank_id": selectedAccount.value.id,
    };

    var _resp = await _withdrawRepo.postWithdraw(body);

    getAllData();
    resetForm();

    if (!_resp.error!) {
      CToast.showWithoutCOntext(
        "Sukses Melakukan Permintaan Penarikan",
        _theme.success[3],
        _theme.pureWhite.value,
      );
      getAccountList();
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        _theme.error[3],
        _theme.pureWhite.value,
      );
    }
  }

  resetForm() {
    nominal.value = 0;
    nominalController.value.text = "";
    selectedAccount.value = AccountModel();
    selectedBank.value = BankModel();
  }
}
