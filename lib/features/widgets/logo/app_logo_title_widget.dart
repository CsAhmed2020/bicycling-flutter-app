import 'package:bicycling_app/res/app_asset_paths.dart';
import 'package:flutter/material.dart';

class AppLogoTitleWidget extends StatelessWidget {
  const AppLogoTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssetPaths.appLogoTitle,
      fit: BoxFit.cover,
    );
  }
}
