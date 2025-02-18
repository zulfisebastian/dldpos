import 'package:dld/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../repository/auth/auth_repo.dart';
import '../../widgets/components/ctoast.dart';
import '../../widgets/pages/loading.dart';
import '../base/base_controller.dart';

class LoginController extends GetxController {
  final BaseController _base = Get.find(tag: 'BaseController');
  final AuthRepo _repo = Get.put(AuthRepo());

  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;

  @override
  void onReady() {
    super.onReady();
  }

  RxBool isAgree = false.obs;
  RxBool isDisabledForm = true.obs;

  checkDisabledForm() {
    isDisabledForm.value =
        email.value.text.length < 10 || password.value.text.length < 6;
    isDisabledForm.refresh();
  }

  submitLogin() async {
    Get.dialog(Loading());

    var body = {
      "email": email.value.text,
      "password": password.value.text,
    };

    // var _resp = await _repo.postLogin(body);

    Get.back();

    // if (_resp.status != null) {
    //   if (_resp.status == 200) {
    //     _base.setToken(_resp.data!.token!);
    //     Get.off(HomePage());
    //   } else {
    //     CToast.showWithoutCOntext(
    //       _resp.message!,
    //       Colors.red,
    //       Colors.white,
    //       ToastGravity.TOP,
    //     );
    //   }
    // }

    if (email.value.text == 'admin@mail.com' &&
        password.value.text == 'admin123') {
      _base.setToken("2314091230940913091230912aioeoqi230");
      Get.off(HomePage());
    } else {
      CToast.showWithoutCOntext(
        "Email / Password salah",
        Colors.red,
        Colors.white,
        ToastGravity.TOP,
      );
    }
  }
}
