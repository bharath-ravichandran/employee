import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomSaveButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // <-- Radius
        ),
      ),
      child: Text(
        'Save',
        style: AppExTheme.titleSmall(context).copyWith(
          color: AppColors.employeeWhite,
        ),
      ),
    );
  }
}
