import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dld/controllers/base/base_controller.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/customButton.dart';
import 'package:dld/widgets/components/profile_menu.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import '../../constants/endpoints.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../widgets/components/ccached_image.dart';
import '../../widgets/sheets/sheet_logout.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final BaseController _base = Get.find(tag: 'BaseController');
  final HomeController _home = Get.find(tag: 'HomeController');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _theme.primary[4],
        resizeToAvoidBottomInset: false,
        body: Container(
          width: OtherExt().getWidth(context),
          height: OtherExt().getHeight(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Container(
                  width: OtherExt().getWidth(context),
                  height: OtherExt().getHeight(context),
                  color: _theme.primary[4],
                ),
              ),
              //Bottom Section
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: () async {
                    //
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: OtherExt().getWidth(context),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/ic_edit.svg",
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 102,
                          height: 102,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CCachedImage(
                                  width: 102,
                                  height: 102,
                                  rounded: 102,
                                  url: Endpoint.defaultImageUrl,
                                ),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_camera.svg",
                                    width: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => CText(
                            _base.profile.value.name ?? "-",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Obx(
                          () => _base.checkIsCustomer()
                              ? Container(
                                  width: OtherExt().getWidth(context),
                                  height: 250,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Column(
                                          children: [
                                            Container(
                                              width:
                                                  OtherExt().getWidth(context),
                                              height: 80,
                                            ),
                                            Container(
                                              width:
                                                  OtherExt().getWidth(context),
                                              height: 170,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                          width: OtherExt().getWidth(context),
                                          decoration: BoxDecoration(
                                            color: _theme.warning[0],
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          margin: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 16,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: OtherExt()
                                                    .getWidth(context),
                                                decoration: BoxDecoration(
                                                  color: _theme.pureWhite.value,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: _theme.line.value,
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: OtherExt()
                                                          .getWidth(context),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            _theme.primary[5],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 38,
                                                            height: 38,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/icons/ic_point.svg",
                                                              width: 24,
                                                              color: _theme
                                                                  .warning[2],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CText(
                                                                "Poin Kamu",
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white54,
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              CText(
                                                                StringExt
                                                                    .thousandFormatter(
                                                                  100,
                                                                ),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          CustomButton(
                                                            "Tukar Reward",
                                                            defaultColor: Colors
                                                                .transparent,
                                                            borderColor:
                                                                Colors.white,
                                                            textColor:
                                                                Colors.white,
                                                            height: 42,
                                                            fontSize: 10,
                                                            paddingVertical: 0,
                                                            onPressed: () {
                                                              //
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/icons/ic_location.svg",
                                                                  width: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                CText(
                                                                  "Alamat Kamu",
                                                                  fontSize: 12,
                                                                  color: _theme
                                                                      .pureBlack
                                                                      .value,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            CustomButton(
                                                              "Rumah Kaliurang",
                                                              rightIcon: Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_outlined,
                                                                size: 16,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              fontSize: 10,
                                                              height: 32,
                                                              paddingVertical:
                                                                  0,
                                                              paddingHorizontal:
                                                                  12,
                                                              textColor:
                                                                  Colors.white,
                                                              defaultColor:
                                                                  Colors.black,
                                                              onPressed: () {
                                                                //
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CText(
                                                                  "Total Setor",
                                                                  fontSize: 12,
                                                                  color: _theme
                                                                      .pureBlack
                                                                      .value,
                                                                ),
                                                                SizedBox(
                                                                  height: 12,
                                                                ),
                                                                CText(
                                                                  15,
                                                                  fontSize: 16,
                                                                  color: _theme
                                                                      .primary[4],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CText(
                                                                  "Total Tukar",
                                                                  fontSize: 12,
                                                                  color: _theme
                                                                      .pureBlack
                                                                      .value,
                                                                ),
                                                                SizedBox(
                                                                  height: 12,
                                                                ),
                                                                CText(
                                                                  3,
                                                                  fontSize: 16,
                                                                  color: _theme
                                                                      .primary[4],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: OtherExt()
                                                    .getWidth(context),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 10.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/ic_info.svg",
                                                      width: 12,
                                                      color: _theme.warning[4],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                      child: CText(
                                                        "Kamu belum menambahkan email untuk metode reset password",
                                                        fontSize: 11,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        color:
                                                            _theme.warning[4],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ),
                        Container(
                          width: OtherExt().getWidth(context),
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              sectionAkun(),
                              SizedBox(
                                height: 40,
                              ),
                              sectionBantuan(),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: ProfileMenu(
                                  onClick: () {
                                    Get.bottomSheet(SheetLogout(onTap: () {
                                      _base.logout();
                                    }));
                                  },
                                  title: "Keluar",
                                  titleColor: _theme.error[2],
                                  icon: Icon(
                                    Icons.logout,
                                    color: _theme.error[2],
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionAkun() {
    return Container(
      width: OtherExt().getWidth(context),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Akun & Keamanan",
            fontSize: 12,
            color: _theme.primary[4],
          ),
          SizedBox(
            height: 10,
          ),
          ProfileMenu(
            onClick: () {
              //
            },
            title: "Data Pribadi",
            titleColor: _theme.pureBlack.value,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
            isWarning: true,
          ),
          ProfileMenu(
            onClick: () {
              //
            },
            title: "Nomor Telepon",
            titleColor: _theme.pureBlack.value,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
          ),
          ProfileMenu(
            onClick: () {
              //
            },
            title: "Email",
            titleColor: _theme.pureBlack.value,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
            isWarning: true,
          ),
        ],
      ),
    );
  }

  Widget sectionBantuan() {
    return Container(
      width: OtherExt().getWidth(context),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            "Pusat Bantuan",
            fontSize: 12,
            color: _theme.primary[4],
          ),
          SizedBox(
            height: 10,
          ),
          ProfileMenu(
            onClick: () {
              //
            },
            title: "Hubungi Kami",
            titleColor: _theme.pureBlack.value,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
          ),
          ProfileMenu(
            onClick: () {
              //
            },
            title: "FAQ",
            titleColor: _theme.pureBlack.value,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
