import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/extensions.dart';
import '../components/customButton.dart';
import '../components/text/ctext.dart';

class UpdateApp extends StatelessWidget {
  final Function oncallbackCancel;
  UpdateApp({
    Key? key,
    required this.oncallbackCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Dialog(
        backgroundColor: Colors.white,
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CText(
                  "New Version is Available",
                  color: Colors.black,
                  align: TextAlign.center,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 24,
                ),
                Image.asset(
                  "assets/photo/img_update.png",
                ),
                SizedBox(
                  height: 24,
                ),
                CText(
                  "Update the app for a better experience.",
                  color: Colors.black,
                  align: TextAlign.center,
                  fontSize: 14,
                  lineHeight: 1.3,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    // if (_base.dataVersion.value.forceUpdate == 0)
                    //   Expanded(
                    //     child: CustomButtonBorderBlack(
                    //       "Later",
                    //       width: OtherExt().getWidth(context),
                    //       onPressed: () {
                    //         oncallbackCancel();
                    //       },
                    //     ),
                    //   ),
                    // if (_base.dataVersion.value.forceUpdate == 0)
                    //   SizedBox(
                    //     width: 8,
                    //   ),
                    Expanded(
                      child: CustomButton(
                        "Update Now",
                        width: OtherExt().getWidth(context),
                        onPressed: () async {
                          // String url =
                          //     _base.dataVersion.value.link_download ?? "";
                          String url =
                              "https://partner.sunmi.com/developManage/app/31662/detail";

                          await launchUrl(Uri.parse(url));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
