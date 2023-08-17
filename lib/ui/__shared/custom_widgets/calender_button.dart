import 'package:employee/ui/__shared/custom_dialogs/show_calender.dart';
import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CalenderButton extends StatefulWidget {
  final bool fromDate;
  CalenderButton({
    super.key,
    required this.fromDate,
  });

  String from = '';
  String to = '';

  @override
  State<CalenderButton> createState() => _CalenderButtonState();
}

class _CalenderButtonState extends State<CalenderButton> {
  String? formattedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var res = await showDialog(
          context: context,
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.employeeWhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: CalendarWidget(fromDate: widget.fromDate),
                    ),
                  ),
                ),
              ],
            );
          },
        );
        if (res != null) {
          formattedDate = DateFormat('dd-MMM-yyyy').format(res);
          if (widget.fromDate) {
            widget.from = formattedDate!;
          } else {
            widget.to = formattedDate!;
          }
        }
        setState(() {});
      },
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
