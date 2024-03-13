import 'package:bicycling_app/_base/base_widgets/base_stateless_widget.dart';
import 'package:bicycling_app/res/app_asset_paths.dart';
import 'package:bicycling_app/utils/locale/app_localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// ignore: must_be_immutable
class PickerOptionWidget extends BaseStatelessWidget {
  final VoidCallback? documentClickedCallBack;
  final VoidCallback cameraClickedCallBack;
  final VoidCallback galleryClickedCallBack;
  PickerOptionWidget(
      {this.documentClickedCallBack,
      required this.cameraClickedCallBack,
      required this.galleryClickedCallBack,
      super.key});

  @override
  Widget baseBuild(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (documentClickedCallBack != null)
                _pickerTypeWidget(
                    translate(LocalizationKeys.document)!,
                    AppAssetPaths.documentPickerIcon,
                    documentClickedCallBack!,
                    context),
              _pickerTypeWidget(
                  translate(LocalizationKeys.camera)!,
                  AppAssetPaths.cameraPickerIcon,
                  cameraClickedCallBack,
                  context),
              _pickerTypeWidget(
                  translate(LocalizationKeys.gallery)!,
                  AppAssetPaths.galleryPickerIcon,
                  galleryClickedCallBack,
                  context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickerTypeWidget(
      String title, String path, VoidCallback callback, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        callback();
      },
      splashColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(path),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
