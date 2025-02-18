import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dld/models/transaction/transaction_model.dart';
import 'package:dld/repository/global/global_repo.dart';
import 'package:dld/repository/transaction/transaction_repo.dart';
import '../../models/global/banner_model.dart';
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
    // var body = {
    //   "per_page": 10,
    //   "page": 1,
    // };

    // var _resp = await _globalRepo.getBanners(body);

    banner.value = [
      BannerModel(
        id: "1",
        image:
            "https://lautandisplay.zidspace.com/wp-content/uploads/2024/04/Spanduk-Promosi-Makanan-3-1-scaled.jpg",
      ),
      BannerModel(
        id: "2",
        image:
            "https://marketplace.canva.com/EAGIBOPhANE/1/0/800w/canva-cokelat-kuning-organik-minimalis-banner-warung-aneka-jajanan-kP9pIcmZi38.jpg",
      ),
    ];
    banner.refresh();
    // if (_resp.status == 200) {
    //   banner.value = _resp.data!.results!;
    //   banner.refresh();
    //   Future.delayed(Duration(seconds: 3), () {
    //     return;
    //   });
    // } else {
    //   CToast.showWithoutCOntext(
    //     _resp.message!,
    //     Colors.red,
    //     Colors.white,
    //     ToastGravity.TOP,
    //   );
    // }
  }

  RxBool showBalance = false.obs;
  RxList<TransactionModel> transaction = RxList<TransactionModel>();
  getListTransaction() async {
    // var body = {
    //   "status": 1,
    // };

    // TransactionListResponse _resp =
    //     await _transactionRepo.getTransactions(body);

    // if (_resp.status == 200) {
    //   transaction.value = _resp.data!.results!;
    //   transaction.refresh();
    // } else {
    //   CToast.showWithoutCOntext(
    //     _resp.message!,
    //     Colors.red,
    //     Colors.white,
    //     ToastGravity.TOP,
    //   );
    // }
    transaction.value = [
      TransactionModel(
        id: "10",
        type: "outcome",
        date: "2025-02-15 22:30:12",
        value: 100,
        payment: "Cash",
        payment_at: "2025-02-15 22:31:12",
      ),
      TransactionModel(
        id: "9",
        type: "income",
        date: "2025-02-15 22:30:12",
        value: 124,
        payment: "Cash",
        payment_at: "2025-02-15 22:31:12",
      ),
      TransactionModel(
        id: "8",
        type: "income",
        date: "2025-02-15 22:00:12",
        value: 82,
        payment: "OVO",
        payment_at: "2025-02-15 22:01:12",
      ),
      TransactionModel(
        id: "7",
        type: "income",
        date: "2025-02-15 21:30:12",
        value: 14,
        payment: "Gopay",
        payment_at: "2025-02-15 21:31:12",
      ),
      TransactionModel(
        id: "6",
        type: "income",
        date: "2025-02-14 21:00:12",
        value: 210,
        payment: "Cash",
        payment_at: "2025-02-14 21:01:12",
      ),
      TransactionModel(
        id: "5",
        type: "income",
        date: "2025-02-14 20:30:12",
        value: 90,
        payment: "OVO",
        payment_at: "2025-02-14 20:31:12",
      ),
      TransactionModel(
        id: "4",
        type: "income",
        date: "2025-02-14 20:00:12",
        value: 40,
        payment: "Gopay",
        payment_at: "2025-02-14 20:01:12",
      ),
      TransactionModel(
        id: "3",
        type: "income",
        date: "2025-02-13 19:30:12",
        value: 34,
        payment: "Cash",
        payment_at: "2025-02-13 19:31:12",
      ),
      TransactionModel(
        id: "2",
        type: "income",
        date: "2025-02-13 19:00:12",
        value: 42,
        payment: "OVO",
        payment_at: "2025-02-13 19:01:12",
      ),
      TransactionModel(
        id: "1",
        type: "income",
        date: "2025-02-13 18:30:12",
        value: 24,
        payment: "Gopay",
        payment_at: "2025-02-13 18:31:12",
      ),
    ];
    transaction.refresh();
  }

  calculateTotalPayToday() {
    var _date = DateTime.now();
    return transaction
        .where((element) =>
            element.date!.substring(0, 10) == _date.toString().substring(0, 10))
        .fold(0, (previousValue, element) {
      if (element.type == "outcome") {
        return previousValue - element.value!;
      } else {
        return previousValue + element.value!;
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
        return previousValue - element.value!;
      } else {
        return previousValue + element.value!;
      }
    });
  }

  calculateBalance() {
    var _date = DateTime.now();
    print(_date.toString().substring(0, 10));

    return transaction.fold(0, (previousValue, element) {
      if (element.type == "outcome") {
        return previousValue - element.value!;
      } else {
        return previousValue + element.value!;
      }
    });
  }
}
