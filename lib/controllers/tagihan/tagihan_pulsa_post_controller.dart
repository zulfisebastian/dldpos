import 'package:dld/controllers/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/ctoast.dart';
import '../../widgets/pages/loading.dart';
import '../base/base_controller.dart';

class TagihanPulsaPostController extends GetxController {
  final scrollController = ScrollController();
  BaseController _base = Get.find(tag: "BaseController");
  ThemeController _theme = Get.find(tag: "ThemeController");
  Rx<TextEditingController> noHp = TextEditingController().obs;

  // final DigiasiaRepo _repo = Get.put(DigiasiaRepo());

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  refreshData() async {
    Get.dialog(
      Loading(),
      barrierDismissible: false,
    );
    await getDataBalance();
    await getListMenuTagihan();
    // getCIFData();
    Get.back();
  }

  RxString resultKode = "".obs;
  RxString typeCode = "".obs;
  RxBool fetchingData = false.obs;

  findKodeFromNoHP() async {
    resultKode.value = StringExt.findPhone(noHp.value.text);
    typeCode.value = resultKode.value
        .replaceAll("assets/images/img_logo_", "")
        .replaceAll(".png", "");
    if (noHp.value.text.length > 10) {
      await fetchPulsa();
      await fetchPackage();
      fetchingData.value = false;
    } else {
      // listPulsa.clear();
      // listPackage.clear();
    }
  }

  // RxList<DataDigiasiaTagihan> listPulsa = <DataDigiasiaTagihan>[].obs;
  fetchPulsa() async {
    // if (!fetchingData.value) {
    //   listPulsa.clear();
    //   fetchingData.value = true;
    //   for (var _data in _listDigiasiaTagihan) {
    //     if (typeCode.value == "im3") {
    //       if (_data.name!.toLowerCase().contains("indosat")) {
    //         listPulsa.add(_data);
    //         listPulsa.refresh();
    //       }
    //     } else if (typeCode.value == "telkomsel") {
    //       if (_data.name!.toLowerCase().contains("simpati")) {
    //         listPulsa.add(_data);
    //         listPulsa.refresh();
    //       }
    //     } else if (typeCode.value == "xl") {
    //       if (_data.name!.toLowerCase().contains("xl")) {
    //         listPulsa.add(_data);
    //         listPulsa.refresh();
    //       }
    //     } else if (typeCode.value == "axis") {
    //       if (_data.name!.toLowerCase().contains("axis")) {
    //         listPulsa.add(_data);
    //         listPulsa.refresh();
    //       }
    //     } else if (typeCode.value == "3") {
    //       if (_data.name!.toLowerCase().contains("three")) {
    //         listPulsa.add(_data);
    //         listPulsa.refresh();
    //       }
    //     } else if (typeCode.value == "smartfren") {
    //       if (_data.name!.toLowerCase().contains("smartfren")) {
    //         listPulsa.add(_data);
    //         listPulsa.refresh();
    //       }
    //     }
    //   }
    //   listPulsa.sort((a, b) => a.nominal!.compareTo(b.nominal!));
    //   fetchingData.value = false;
    // }
  }

  // RxList<DataDigiasiaTagihan> listPackage = <DataDigiasiaTagihan>[].obs;
  fetchPackage() async {
    // if (!fetchingData.value) {
    //   listPackage.clear();
    //   fetchingData.value = true;
    //   for (var _data in _listDigiasiaTagihan) {
    //     if (typeCode.value == "im3") {
    //       if (_data.desc!.toLowerCase().contains("indosat")) {
    //         listPackage.add(_data);
    //         listPackage.refresh();
    //       }
    //     } else if (typeCode.value == "telkomsel") {
    //       if (_data.desc!.toLowerCase().contains("telkomsel")) {
    //         listPackage.add(_data);
    //         listPackage.refresh();
    //       }
    //     } else if (typeCode.value == "xl") {
    //       if (_data.desc!.toLowerCase().contains("xl")) {
    //         listPackage.add(_data);
    //         listPackage.refresh();
    //       }
    //     } else if (typeCode.value == "axis") {
    //       if (_data.desc!.toLowerCase().contains("axis")) {
    //         listPackage.add(_data);
    //         listPackage.refresh();
    //       }
    //     } else if (typeCode.value == "3") {
    //       if (_data.desc!.toLowerCase().contains("three")) {
    //         listPackage.add(_data);
    //         listPackage.refresh();
    //       }
    //     } else if (typeCode.value == "smartfren") {
    //       if (_data.desc!.toLowerCase().contains("smartfren")) {
    //         listPackage.add(_data);
    //         listPackage.refresh();
    //       }
    //     }
    //   }
    //   listPackage.sort(
    //       // (a, b) => (a.price! + a.fee!).compareTo(b.price! + b.fee!),
    //       );
    //   fetchingData.value = false;
    // }
  }

  RxBool isDisabled = true.obs;
  changeDisabled() {
    // isDisabled.value = choosedTab.value == "Pulsa"
    //     ? noHp.value.text == "" ||
    //         choosedDigiasiaPulsaTagihan.value == DataDigiasiaTagihan()
    //     : noHp.value.text == "" ||
    //         choosedDigiasiaPackageTagihan.value == DataDigiasiaTagihan();
  }

  RxString choosedTab = "Pulsa".obs;

  // RxList<DataDigiasiaTagihan> _listDigiasiaTagihan =
  //     <DataDigiasiaTagihan>[].obs;
  // Rx<DataDigiasiaTagihan> choosedDigiasiaPulsaTagihan =
  //     DataDigiasiaTagihan().obs;
  // Rx<DataDigiasiaTagihan> choosedDigiasiaPackageTagihan =
  //     DataDigiasiaTagihan().obs;
  getListMenuTagihan() async {
    var body = {
      "productCode": "PL",
      "account": "PL",
      "params": [],
    };

    // var _resp = await _repo.getAllTagihan(body);

    // if (_resp.success != null) {
    //   if (_resp.success!) {
    //     _listDigiasiaTagihan.clear();
    //     for (var _data in _resp.data!.data!) {
    //       if (_data.category == "Airtime" || _data.category == "DataPackage")
    //         _listDigiasiaTagihan.add(_data);
    //     }
    //     _listDigiasiaTagihan.refresh();
    //   }
    // }
  }

  // Rx<DataDigiasiaBalance> digiasiaBalance = DataDigiasiaBalance().obs;
  getDataBalance() async {
    // var _resp = await _repo.getBalance();

    // if (_resp.success != null) {
    //   if (_resp.success!) {
    //     digiasiaBalance.value = _resp.data!;
    //     digiasiaBalance.refresh();
    //   }
    // }
  }

  RxString provider = "".obs;
  getRincian(context) {
    provider.value = StringExt.getProviderPhone(typeCode.value);
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   isDismissible: true,
    //   enableDrag: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (BuildContext _) {
    //     if (choosedTab.value == "Pulsa") {
    //       // return RincianTagihanPulsaPra(
    //       //   billerData: choosedDigiasiaPulsaTagihan.value,
    //       //   hp: noHp.value.text,
    //       //   provider: provider.value,
    //       //   onTap: () {
    //       //     Navigation().toPinVerification(
    //       //       () {
    //       //         payPulsa(context);
    //       //       },
    //       //     );
    //       //   },
    //       // );
    //     } else {
    //       // return RincianTagihanPulsaPackage(
    //       //   billerData: choosedDigiasiaPackageTagihan.value,
    //       //   hp: noHp.value.text,
    //       //   provider: provider.value,
    //       //   onTap: () {
    //       //     Navigation().toPinVerification(
    //       //       () {
    //       //         payPulsa(context);
    //       //       },
    //       //     );
    //       //   },
    //       // );
    //     }
    //   },
    // );
  }

  payPulsa(context) async {
    var body = {
      // "productCode": choosedTab.value == "Pulsa"
      //     ? choosedDigiasiaPulsaTagihan.value.code
      //     : choosedDigiasiaPackageTagihan.value.code,
      // "mobileNumber": noHp.value.text,
      // "amount": choosedTab.value == "Pulsa"
      //     ? choosedDigiasiaPulsaTagihan.value.price! +
      //         choosedDigiasiaPulsaTagihan.value.fee!
      //     : choosedDigiasiaPackageTagihan.value.price! +
      //         choosedDigiasiaPackageTagihan.value.fee!,
      // "reffId": "",
      // "sourceMobileNumber": dataProfileCIF.value.cif!.mobileNumber,
    };

    Get.dialog(
      Loading(),
      barrierDismissible: false,
    );

    // var _resp = await _repo.payPulsaPra(body);
    // Get.back();

    // if (_resp.success != null) {
    //   if (_resp.success!) {
    //     // Navigation().toDialogTagihanPulsaPra();
    //   } else {
    //     Get.back();
    //     Get.back();
    //     CToast.showWithoutCOntext(
    //       _resp.messages != null
    //           ? _resp.messages!.first
    //           : "Sepertinya Ada Kendala",
    //       _theme.error[3],
    //       _theme.pureWhite.value,
    //       ToastGravity.TOP,
    //     );
    //   }
    // }
  }
}
