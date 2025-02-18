import 'dart:async';
import 'package:camera/camera.dart';
import 'package:dld/models/auth/login_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lc;
import 'package:dld/repository/auth/auth_repo.dart';
import '../../pages/auth/login_page.dart';
import '../../utils/shared_pref.dart';
import '../../widgets/components/ctoast.dart';

class BaseController extends GetxController {
  RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  lc.Location location = new lc.Location();
  final Completer<GoogleMapController> mapController = Completer();

  RxInt currentTooltip = 0.obs;

  final RxInt _currentPage = 0.obs;
  RxInt get currentPage => _currentPage;

  final PageController pageController = PageController();

  final RxBool isConnectivity = true.obs;

  RxBool deviceIOS = true.obs;
  RxBool isLogout = false.obs;

  RxBool tabEnabled = true.obs;

  final AuthRepo _authRepo = AuthRepo();

  logout() async {
    await SharedPref.clearVariable();
    isLogout.value = true;
    Get.offAll(
      LoginPage(),
    );
  }

  @override
  void onReady() {
    setCamera();
    super.onReady();
  }

  setCamera() async {
    cameras.value = await availableCameras();
  }

  setPage(int page) {
    _currentPage.value = page;
    // pageController.jumpToPage(page);
  }

  int getPage() {
    return _currentPage.value;
    // pageController.jumpToPage(page);
  }

  RxString roleUser = "".obs;

  changeRole(String role) {
    SharedPref.putString(SharedPref.role, role);
    roleUser.value = role;
    roleUser.refresh();
  }

  setToken(String token) {
    SharedPref.putString(SharedPref.accessToken, token);
  }

  setRole() async {
    roleUser.value = await SharedPref.getString(SharedPref.role);
  }

  bool checkIsCustomer() {
    print(roleUser.value);
    if (roleUser.value.isEmpty) {
      setRole();
    }
    return roleUser.value == "Pelanggan";
  }

  notificationClicked(
    String type,
    String transactionCode,
    String commentCode,
    String postCode,
    bool canClicked,
    bool fromPushNotif,
    String file,
  ) {
    // NotificationController _control = Get.put(NotificationController());

    // if (type == "mood_tracker") {
    //   if (fromPushNotif) Navigation().toDashboard();
    //   Get.to(
    //     MemoriesAddPage(
    //       data: MemoriesData(
    //         moodCode: "",
    //       ),
    //       title: DateExt.reformat(
    //         DateTime.now().toString(),
    //         "yyyy-MM-dd",
    //         "dd MMM yyyy",
    //       ),
    //       from: "push notification",
    //     ),
    //   );
    // } else if (type == "nps") {
    //   if (fromPushNotif) Navigation().toDashboard();
    //   Navigation().toAssestment(type);
    // } else if (type == "flourishing" ||
    //     type == "gallup_12" ||
    //     type == "dass_21" ||
    //     type == "nps") {
    //   if (fromPushNotif) Navigation().toDashboard();
    //   Navigation().toAssestment(type);
    // } else if (type == "apps") {
    //   if (fromPushNotif) Navigation().toDashboard();
    //   Navigation().toProvideFeedback();
    // } else if (type == "leave_a_comment") {
    //   if (fromPushNotif) Navigation().toDashboard();
    //   MainController _main = Get.find(tag: 'mainController');
    //   _main.setPage(0);
    // } else if (type == "like_comment") {
    //   if (canClicked) {
    //     if (commentCode == "") {
    //       _control.fetchDataComment(
    //         type,
    //         postCode,
    //         transactionCode,
    //       );
    //     } else {
    //       _control.fetchDataComment(
    //         type,
    //         postCode,
    //         commentCode,
    //       );
    //     }
    //   }
    // } else if (type == "reply_comment") {
    //   if (canClicked) {
    //     _control.fetchDataComment(
    //       type,
    //       postCode,
    //       commentCode,
    //     );
    //   }
    // } else if (type == "reservation_confirmed") {
    //   if (fromPushNotif) Navigation().toDashboard();
    //   Get.to(
    //     CounselingDetailPage(
    //       reservationCode: transactionCode,
    //       isPast: false,
    //     ),
    //   );
    // } else if (type == "chat") {
    //   if (checkIsPsycholog()) {
    //     Navigation().toDashboard();
    //     setPage(2);
    //   } else {
    //     Navigation().toDashboard();
    //     Navigation().toChooseCrisis();
    //     //
    //   }
    // } else {
    //   //
    // }
  }

  removeFocus(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Rx<LoginModel> profile = LoginModel().obs;
  getProfile() async {
    // var _resp = await _authRepo.getProfile();

    profile.value = LoginModel(
      id: "1",
      name: "Admin",
      token: "2134031401304kao230412r0j",
    );
    profile.refresh();

    //   if (_resp.status == 200) {
    //     profile.value = _resp.data!;
    //     profile.refresh();
    //   } else {
    //     CToast.showWithoutCOntext(
    //       _resp.message!,
    //       Colors.red,
    //       Colors.white,
    //       ToastGravity.TOP,
    //     );
    //   }
  }
}
