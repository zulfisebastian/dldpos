import 'dart:io';
import 'package:dld/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'controllers/base/base_controller.dart';
import 'controllers/theme/theme_controller.dart';
import 'pages/auth/login_page.dart';
import 'pages/splash/splash_page.dart';
import 'services/analytics.dart';
import 'services/init_depedencies.dart';
import 'utils/shared_pref.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  Get.put(BaseController(), tag: 'BaseController');
  Get.put(ThemeController(), tag: 'ThemeController');
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = new MyHttpOverrides();
  await InitDepedencies().initPlatformState();
  await InitDepedencies().getVersionCode();
  await InitDepedencies().checkDeviceType();
  await InitDepedencies().initErrorWidget();

  // calculate token expired date
  String _accessToken = await SharedPref.getString(SharedPref.accessToken);
  bool _isNeedLogin = true;
  if (_accessToken.isNotEmpty) {
    _isNeedLogin = false;
  } else {
    _isNeedLogin = true;
  }

  // bool _isVersionValidate = true;
  // _isVersionValidate = await _controller.checkVersion();

  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
      MyApp(
        isDev: false,
        page: _isNeedLogin
            ? SplashPage(
                onTimeFinish: () => Get.offAll(LoginPage()),
              )
            : SplashPage(
                onTimeFinish: () => Get.offAll(HomePage()),
              ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? page;
  final bool isDev;
  const MyApp({
    Key? key,
    this.page,
    required this.isDev,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final BaseController _base = Get.find(tag: 'BaseController');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        print("INACTIVE");
        break;
      case AppLifecycleState.paused:
        print("PAUSED");
        break;
      case AppLifecycleState.detached:
        print("DETACH");
        break;
      case AppLifecycleState.resumed:
        print("RESUMED");
        break;
      case AppLifecycleState.hidden:
        print("HIDDEN");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: _theme.backgroundPage.value,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: widget.isDev,
      themeMode: ThemeMode.light,
      title: 'DLD POS',
      home: widget.page,
    );
  }
}
