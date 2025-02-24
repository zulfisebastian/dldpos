import 'package:flutter/material.dart';
import 'package:dld/constants/endpoints.dart';
import 'package:dld/utils/extensions.dart';
import 'package:dld/widgets/components/ccached_image.dart';
import '../../models/global/banner_model.dart';

class BannerCard extends StatelessWidget {
  final BannerModel data;

  BannerCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CCachedImage(
      width: OtherExt().getWidth(context) * .8,
      height: 120,
      url: data.asset_url ?? Endpoint.defaultImageUrl,
    );
  }
}
