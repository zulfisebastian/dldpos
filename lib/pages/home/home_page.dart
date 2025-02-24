import 'package:dld/pages/transaction/transaction_page.dart';
import 'package:dld/widgets/card/transaction_card.dart';
import 'package:dld/widgets/components/cdivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dld/constants/endpoints.dart';
import 'package:dld/pages/profile/profile_page.dart';
import 'package:dld/widgets/components/ccached_image.dart';
import 'package:dld/widgets/components/text/ctext.dart';
import '../../controllers/base/base_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/extensions.dart';
import '../../widgets/card/banner_card.dart';
import '../../widgets/components/cheader.dart';
import '../../widgets/components/cheader_section.dart';
import '../pos/pos_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final BaseController _base = Get.find(tag: 'BaseController');
  final HomeController _home = Get.put(
    HomeController(),
    tag: 'HomeController',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _home.getAllData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _theme.pureWhite.value,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: OtherExt().getWidth(context),
          height: OtherExt().getHeight(context),
          child: RefreshIndicator(
            onRefresh: () async {
              _home.getAllData();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                spacing: 20,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 12,
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(
                                ProfilePage(),
                              ),
                              behavior: HitTestBehavior.opaque,
                              child: CCachedImage(
                                width: 40,
                                height: 40,
                                rounded: 40,
                                url: Endpoint.defaultImageUrl,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => CText(
                                    _base.profile.value.id != null
                                        ? "Hi ${_base.profile.value.full_name!}"
                                        : "-",
                                    color: _theme.pureBlack.value,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CText(
                                  "Selamat Datang di DLD POS",
                                  fontSize: 12,
                                  color: _theme.pureBlack.value.withAlpha(180),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/images/logo_long.png",
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _theme.pureWhite.value,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _theme.line.value,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 8,
                    ),
                    child: Column(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            spacing: 12,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/ic_wallet.svg",
                                width: 32,
                                height: 32,
                              ),
                              Column(
                                spacing: 6,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CText(
                                    "Your Balance",
                                    fontSize: 13,
                                    color: _theme.pureBlack.value,
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Obx(
                                        () => CText(
                                          _home.showBalance.value
                                              ? "IDR ${StringExt.thousandFormatter(_home.calculateBalance())}"
                                              : "****",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: _theme.pureBlack.value,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _home.showBalance.value =
                                              !_home.showBalance.value;
                                        },
                                        child: Obx(
                                          () => Icon(
                                            _home.showBalance.value
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            size: 16,
                                            color: _theme.pureBlack.value,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: OtherExt().getWidth(context),
                          decoration: BoxDecoration(
                            color: _theme.pureBlack.value.withAlpha(10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            spacing: 16,
                            children: [
                              CMenu(
                                onTap: () {
                                  Get.to(PosPage());
                                },
                                icon: "ic_order",
                                title: "Order",
                                isActive: true,
                              ),
                              CMenu(
                                onTap: () {
                                  Get.to(TransactionPage());
                                },
                                icon: "ic_transaction",
                                title: "History",
                                isActive: true,
                              ),
                              CMenu(
                                onTap: () {},
                                icon: "ic_withdraw",
                                title: "Tarik",
                                isActive: false,
                              ),
                              CMenu(
                                onTap: () {},
                                icon: "ic_report",
                                title: "Report",
                                isActive: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: _theme.pureWhite.value,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: _theme.line.value,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _theme.line.value,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: _theme.primary[4],
                                  size: 16,
                                ),
                              ),
                              CText(
                                "Total Order",
                                fontSize: 12,
                                color: _theme.pureBlack.value.withAlpha(150),
                              ),
                              Obx(
                                () => CText(
                                  "${StringExt.thousandFormatter(_home.calculateTotalTrx())}",
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: _theme.pureBlack.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: _theme.pureWhite.value,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: _theme.line.value,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _theme.line.value,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: _theme.primary[4],
                                  size: 16,
                                ),
                              ),
                              CText(
                                "Today Income",
                                fontSize: 12,
                                color: _theme.pureBlack.value.withAlpha(150),
                              ),
                              Obx(
                                () => CText(
                                  "${StringExt.thousandFormatter(_home.calculateTotalPayToday() / 1000)} K",
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: _theme.pureBlack.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: _theme.pureWhite.value,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: _theme.line.value,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _theme.line.value,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: _theme.primary[4],
                                  size: 16,
                                ),
                              ),
                              CText(
                                "All Income",
                                fontSize: 12,
                                color: _theme.pureBlack.value.withAlpha(150),
                              ),
                              Obx(
                                () => CText(
                                  "${StringExt.thousandFormatter(_home.calculateTotalPayAll() / 1000)} K",
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: _theme.pureBlack.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: CHeaderSection(
                      title: CHeader(title: "Promo Hari Ini"),
                      action: SizedBox(),
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: Obx(
                      () => ListView.separated(
                        itemCount: _home.banner.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 16,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var _data = _home.banner[index];
                          return BannerCard(data: _data);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: CHeaderSection(
                      title: CHeader(title: "Transaksi Terakhir"),
                      action: GestureDetector(
                        onTap: () {
                          Get.to(TransactionPage());
                        },
                        child: Row(
                          spacing: 4,
                          children: [
                            CText(
                              "Lihat",
                              color: _theme.primary[4],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 12,
                              color: _theme.primary[4],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => ListView.separated(
                      itemCount: _home.transaction.length > 5
                          ? 5
                          : _home.transaction.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return CDivider(height: 1);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var _data = _home.transaction[index];
                        return TransactionCard(data: _data);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  scrollToTop() {
    _home.scrollController.animateTo(
      _home.scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}

class CMenu extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String icon;
  final bool isActive;

  CMenu({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isActive,
  });

  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        height: 56,
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isActive
                ? SvgPicture.asset(
                    "assets/icons/$icon.svg",
                    width: 24,
                  )
                : SvgPicture.asset(
                    "assets/icons/$icon.svg",
                    colorFilter: ColorFilter.mode(
                      _theme.disabled.value,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                  ),
            CText(
              title,
              fontSize: 12,
              spacing: 1,
              color: isActive ? _theme.pureBlack.value : _theme.disabled.value,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
