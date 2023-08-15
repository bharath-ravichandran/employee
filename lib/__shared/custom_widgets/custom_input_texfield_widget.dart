import 'package:employee/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputTextFieldWidget extends StatelessWidget {
  final String hintLabel;
  final String? initialValue;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextStyle? hintStyle;
  final int? maxLines;
  final bool readOnly;

  const CustomInputTextFieldWidget({
    Key? key,
    required this.hintLabel,
    this.onTap,
    this.onChanged,
    required this.controller,
    this.inputType,
    this.inputFormatters,
    this.suffixWidget,
    this.prefixWidget,
    this.validator,
    this.hintStyle,
    this.maxLines,
    this.readOnly = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: initialValue,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.employeeTextBlack,
              ),
          readOnly: readOnly,
          autofocus: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.employeeWhite,
          inputFormatters: inputFormatters,
          keyboardType: inputType,
          controller: controller,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintLabel,
            hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: AppColors.employeeTextBlack.withOpacity(0.5),
                ),
            filled: true,
            fillColor: AppColors.employeeWhite.withOpacity(0.1),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: AppColors.employeeTextBlack),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppColors.employeeTextBlack.withOpacity(0.5)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: AppColors.employeeError),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: AppColors.employeeError,
              ),
            ),
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
          ),
        ),
      ],
    );
  }
}
