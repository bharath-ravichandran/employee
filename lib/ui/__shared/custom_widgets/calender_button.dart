import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CalenderButton extends StatelessWidget {
  final DateTime? date;
  final Function() onTap;

  const CalenderButton({
    super.key,
    required this.onTap,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              date.toString() != null ? 'No Date' : date.toString(),
              style: AppExTheme.bodySmall(context)
                  .copyWith(color: date.toString() != null ? AppColors.employeeGrey : AppColors.employeeTextBlack),
            ),
          ],
        ),
      ),
    );
  }
}
