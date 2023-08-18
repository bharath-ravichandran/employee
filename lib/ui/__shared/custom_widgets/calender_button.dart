import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CalenderButton extends StatelessWidget {
  final bool fromDate;
  final Function() callBack1;
  const CalenderButton({
    super.key,
    required this.fromDate,
    required this.callBack1,
    this.formattedDate,
  });

  final String? formattedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.calendar),
            const SizedBox(width: 20),
            Text(
              formattedDate ?? 'No Date',
              style: AppExTheme.bodySmall(context)
                  .copyWith(color: formattedDate != null ? AppColors.employeeTextBlack : AppColors.employeeGrey),
            ),
          ],
        ),
      ),
    );
  }
}
