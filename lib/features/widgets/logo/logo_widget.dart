import 'package:bicycling_app/res/app_asset_paths.dart';
import 'package:flutter/material.dart';

class VivasLogo extends StatelessWidget {
  final double height;
  final double width;
  const VivasLogo({Key? key, this.height = 25, this.width = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssetPaths.appLogo,
      width: width,
      fit: BoxFit.cover,
      height: height,
    );
  }
}
