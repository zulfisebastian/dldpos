import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dld/constants/endpoints.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/ccached_image.dart';
import '../../controllers/theme/theme_controller.dart';

class WasteShimmer extends StatelessWidget {
  final ThemeController _theme = Get.find(tag: "ThemeController");

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _theme.pureBlack.value.withValues(alpha: 0.1),
      highlightColor: Colors.white,
      child: Container(
        width: (OtherExt().getWidth(context) - 56) / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _theme.line.value,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: CCachedImage(
                        width: OtherExt().getWidth(context),
                        height: 200,
                        url: Endpoint.defaultImageUrl,
                        rounded: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                    width: 100,
                    height: 10,
                    color: _theme.primary[4],
                  ),
                  Container(
                    width: 100,
                    height: 8,
                    color: _theme.primary[4],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
