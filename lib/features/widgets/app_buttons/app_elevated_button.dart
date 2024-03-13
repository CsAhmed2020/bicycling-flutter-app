import 'package:bicycling_app/features/widgets/app_buttons/common_widgets.dart';
import 'package:bicycling_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Color? color;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;

  const AppElevatedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.color,
    this.padding,
    this.shape,
  }) : super(key: key);

  factory AppElevatedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color? textColor,
    Color? color,
    OutlinedBorder? shape,
    required String title,
  }) {
    return AppElevatedButton(
      key: key,
      padding: padding,
      color: color,
      shape: shape,
      label: labelTextWidget(title, textColor),
      onPressed: onPressed,
    );
  }
  factory AppElevatedButton.whiteWithTitle({
    Key? key,
    VoidCallback? onPressed,
    required String title,
  }) {
    return AppElevatedButton(
      key: key,
      label: labelTextWidget(title, AppColors.appButtonBlueText),
      color: AppColors.appButtonWhiteBackground,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
          elevation: 1,
          shape: shape ??
              RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: AppColors.appButtonBorder,
                  ),
                  borderRadius: BorderRadius.circular(10)),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: label);
  }
}
