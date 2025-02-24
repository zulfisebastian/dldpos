import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dld/models/transaction/transaction_model.dart';
import 'package:dld/repository/global/global_repo.dart';
import 'package:dld/repository/transaction/transaction_repo.dart';
import '../../models/global/banner_model.dart';
import '../../widgets/components/ctoast.dart';
import '../../widgets/pages/loading.dart';
import '../base/base_controller.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();
  final BaseController _base = Get.find(tag: 'BaseController');

  final CarouselSliderController carouselController =
      CarouselSliderController();

  final TransactionRepo _transactionRepo = TransactionRepo();
  final GlobalRepo _globalRepo = GlobalRepo();

  @override
  void onReady() {
    super.onReady();
    getAllData();
  }

  RxInt currentSlide = 0.obs;

  void setCurrentSlide(int index) {
    currentSlide.value = index;
  }

  getAllData() async {
    Get.dialog(
      Loading(),
      barrierDismissible: false,
    );
    _base.getProfile();
    await getDataBanner();
    await getListTransaction();
    Get.back();
  }

  RxList<BannerModel> banner = RxList<BannerModel>();
  getDataBanner() async {
    var body = {
      "per_page": 10,
      "page": 1,
    };

    var _resp = await _globalRepo.getBanners(body);
    if (!_resp.error!) {
      banner.value = _resp.data!;
      banner.refresh();
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        Colors.red,
        Colors.white,
        ToastGravity.TOP,
      );
    }
  }

  RxBool showBalance = false.obs;
  RxList<TransactionModel> transaction = RxList<TransactionModel>();
  getListTransaction() async {
    var body = {
      "status": 1,
    };

    TransactionListResponse _resp =
        await _transactionRepo.getTransactions(body);

    if (!_resp.error!) {
      transaction.value = _resp.data!;
      transaction.refresh();
    } else {
      CToast.showWithoutCOntext(
        _resp.message!,
        Colors.red,
        Colors.white,
        ToastGravity.TOP,
      );
    }
  }

  calculateTotalPayToday() {
    var _date = DateTime.now();
    return transaction
        .where((element) =>
            element.created_at!.substring(0, 10) ==
            _date.toString().substring(0, 10))
        .fold(0, (previousValue, element) {
      if (element.type == "outcome") {
        return previousValue - element.total!;
      } else {
        return previousValue + element.total!;
      }
    });
  }

  calculateTotalTrx() {
    return transaction.fold(0, (previousValue, element) {
      if (element.type == "outcome") {
        return previousValue - 1;
      } else {
        return previousValue + 1;
      }
    });
  }

  calculateTotalPayAll() {
    return transaction.fold(0, (previousValue, element) {
      if (element.type == "outcome") {
        return previousValue - element.total!;
      } else {
        return previousValue + element.total!;
      }
    });
  }

  calculateBalance() {
    var _date = DateTime.now();
    print(_date.toString().substring(0, 10));

    return transaction.fold(0, (previousValue, element) {
      if (element.type == "outcome") {
        return previousValue - element.total!;
      } else {
        return previousValue + element.total!;
      }
    });
  }
}
