import 'package:bicycling_app/_base/base_widgets/base_stateless_widget.dart';
import 'package:bicycling_app/res/app_colors.dart';
import 'package:bicycling_app/utils/extensions/extension_string.dart';
import 'package:bicycling_app/utils/locale/app_localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';


// ignore: must_be_immutable
class PhoneNumberFormFiledWidget extends BaseStatelessWidget {
  final String title;
  final bool requiredTitle;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final PhoneNumber? initialValue;
  final void Function(PhoneNumber?) onSaved;
  final void Function(String?)? onFieldSubmitted;
  final void Function(PhoneNumber?)? onChanged;
  final TextInputAction? textInputAction;
  final PhoneController? controller;
  final bool enable;
  final bool allowEmpty;
  final Color? enableBorderColor;
  final Color? focusColor;
  final FocusNode? focusNode;
  final double radius;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  PhoneNumberFormFiledWidget({
    super.key,
    required this.title,
    this.requiredTitle = true,
    required this.onSaved,
    this.helperText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.initialValue,
    this.onFieldSubmitted,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.enable = true,
    this.enableBorderColor,
    this.focusColor,
    this.inputFormatters,
    this.allowEmpty = false,
    this.radius = 10,
  })  : assert(initialValue == null || controller == null);

  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          requiredTitle ? title.concatenateAsterisk : title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.appFormFieldTitle,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Directionality(
          textDirection: TextDirection.ltr,
          child: PhoneFormField(
            controller: controller,
            autovalidateMode: autovalidateMode,
            autofillHints: const [AutofillHints.telephoneNumber],
            countrySelectorNavigator:
                const CountrySelectorNavigator.draggableBottomSheet(),
            defaultCountry: IsoCode.EG,
            decoration: InputDecoration(
              labelText: labelText,
              helperText: helperText,
              hintText: hintText,
              fillColor: AppColors.appFormFieldFill,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              hintStyle: textTheme.labelMedium?.copyWith(
                color: AppColors.formFieldHintText,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color:
                      enableBorderColor ?? AppColors.enabledAppFormFieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  color: focusColor ?? AppColors.formFieldFocusIBorder,
                ),
              ),
              focusColor: focusColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            enabled: enable,
            showFlagInInput: true,
            validator: _getValidator(),
            cursorColor: Theme.of(context).colorScheme.primary,
            onSaved: onSaved,
            onChanged: onChanged,
            textInputAction: textInputAction,
            isCountryChipPersistent: true,
            countryCodeStyle: textTheme.bodyMedium?.copyWith(color: AppColors.formFieldText),
            focusNode: focusNode,
            initialValue: initialValue,
            inputFormatters: inputFormatters,
            onSubmitted: onFieldSubmitted,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.formFieldText),
          ),
        ),
      ],
    );
  }

  PhoneNumberInputValidator? _getValidator() {
    List<PhoneNumberInputValidator> validators = [];

    validators.add(PhoneValidator.validMobile(
      allowEmpty: allowEmpty,
        errorText: translate(LocalizationKeys.phoneNumberInvalid)));

    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }
}
