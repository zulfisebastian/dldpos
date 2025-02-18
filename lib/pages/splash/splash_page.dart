import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dld/utils/extensions.dart';

class SplashPage extends StatefulWidget {
  final Function onTimeFinish;
  const SplashPage({Key? key, required this.onTimeFinish}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // final ThemeController _theme = Get.find(tag: 'ThemeController');

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );

    Future.delayed(Duration(seconds: 3), () {
      widget.onTimeFinish();
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    ); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: OtherExt().getWidth(context),
        height: OtherExt().getHeight(context),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/logo.svg",
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
