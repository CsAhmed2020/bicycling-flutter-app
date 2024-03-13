import 'package:bicycling_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:bicycling_app/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SubmitButtonWidget extends StatelessWidget {
  final String title;
  final String? hint;
  final VoidCallback? onClicked;
  const SubmitButtonWidget(
      {super.key, required this.title, this.hint, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 40,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...!hint.isNullOrEmpty
              ? [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      hint!,
                      style: const TextStyle(
                        color: Color(0xFF667084),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ]
              : [const SizedBox(height: 24)],
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: AppElevatedButton(
              label: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: onClicked,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
