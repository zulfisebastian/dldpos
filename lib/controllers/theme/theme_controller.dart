import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/shared_pref.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> selectedTheme = ThemeData().obs;

  RxString theme = "Dark".obs;

  @override
  void onReady() {
    initTheme();
    selectedTheme.refresh();
    super.onReady();
  }

  initTheme() async {
    var _oldTheme = await SharedPref.getTheme();
    changeTheme(_oldTheme != "" ? _oldTheme : "Light");
  }

  Rx<Color> backgroundApp = Color(0XFFDDE3FE).obs;
  Rx<Color> line = Color(0XFFE0E5ED).obs;
  Rx<Color> link = Color(0XFF0082c9).obs;
  Rx<Color> disabled = Color(0XFF999999).obs;
  Rx<Color> pureWhite = Color(0XFFFFFFFF).obs;
  Rx<Color> pureBlack = Color(0XFF000000).obs;
  RxList<Color> primary = <Color>[
    Color(0XFFCCECF7),
    Color(0XFF99D8EF),
    Color(0XFF67C5E8),
    Color(0XFF34B1E0),
    Color(0XFF1D91BC),
    Color(0XFF177193),
    Color(0XFF105169),
  ].obs;
  RxList<Color> secondary = <Color>[
    Color(0XFFD0F3E0),
    Color(0XFFA1E7C0),
    Color(0XFF71DCA1),
    Color(0XFF42D082),
    Color(0XFF2BAC65),
    Color(0XFF22864F),
    Color(0XFF186038),
  ].obs;
  RxList<Color> accent = <Color>[
    Color(0XFFCCD7F7),
    Color(0XFF9AAEEF),
    Color(0XFF6886E7),
    Color(0XFF355DDF),
    Color(0XFF1F46C3),
    Color(0XFF183698),
    Color(0XFF11276D),
  ].obs;
  RxList<Color> neutral = <Color>[
    Color(0XFFE4E4E4),
    Color(0XFFD2D2D2),
    Color(0XFFBFBFBF),
    Color(0XFFACACAC),
    Color(0XFF9A9A9A),
    Color(0XFF878787),
    Color(0XFF757575),
    Color(0XFF626262),
    Color(0XFF4F4F4F),
    Color(0XFF3D3D3D),
  ].obs;
  RxList<Color> error = <Color>[
    Color(0XFFF7B0AA),
    Color(0XFFEE6055),
    Color(0XFFE92D1F),
    Color(0XFFB91F13),
    Color(0XFF83160D),
  ].obs;
  RxList<Color> warning = <Color>[
    Color(0XFFFFE9AA),
    Color(0XFFFFD355),
    Color(0XFFFFBD00),
    Color(0XFFC69200),
    Color(0XFF8C6800),
  ].obs;
  RxList<Color> success = <Color>[
    Color(0XFFC3E6C1),
    Color(0XFF86CD82),
    Color(0XFF5BBB56),
    Color(0XFF41973C),
    Color(0XFF2E6B2B),
  ].obs;

  changeTheme(_newTheme) {
    SharedPref.setTheme(_newTheme);
    theme.value = _newTheme;
    // if (theme.value == "Light") {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.light,
    //     ),
    //   );

    //   backgroundApp.value = Color(0XFFFFFFFF);
    //   line.value = Color(0XFFE0E5ED);
    //   disabled.value = Color(0XFF999999);
    // } else {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarColor: Color(0XFF212121),
    //       statusBarIconBrightness: Brightness.dark,
    //     ),
    //   );

    //   backgroundApp.value = Color(0XFF212121);
    //   line.value = Color(0XFFCCCCCC);
    //   disabled.value = Color(0XFF999999);
    // }
  }
}
