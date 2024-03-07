import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../_base/base_widgets/base_stateless_widget.dart';
import '../../res/app_asset_paths.dart';
import '../extensions/extension_colors.dart';
import '../locale/app_localization_keys.dart';

// ignore: must_be_immutable
class StatusWidget extends BaseStatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonTitle;
  final VoidCallback onAction;

  StatusWidget.noMessage(
      {super.key,
      this.image = AppAssetPaths.appLogo,
      this.title = LocalizationKeys.appName,
      this.description = LocalizationKeys.appName,
      this.buttonTitle = LocalizationKeys.appName,
      required this.onAction});

  StatusWidget.noFavorites(
      {super.key,
      this.image = AppAssetPaths.appLogo,
      this.title = LocalizationKeys.appName,
      this.description =
          LocalizationKeys.appName,
      this.buttonTitle = LocalizationKeys.appName,
      required this.onAction});



  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 184, left: 43, right: 43),
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(image),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              translate(title)!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              translate(description)!,
              style: TextStyle(
                color: HexColor.fromHex('9E9E9E'),
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: SizedBox(
              width: 167,
              height: 55,
              child: ElevatedButton(
                onPressed: onAction,
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      HexColor.fromHex('1151B4')),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                ),
                child: Text(
                  translate(buttonTitle)!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
