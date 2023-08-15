import 'package:employee/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CalenderButton extends StatelessWidget {
  final String? date;
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
            const Icon(
              Icons.calendar_month,
              color: Colors.black,
            ),
            const SizedBox(width: 20),
            Text(
              date ?? 'No Date',
              style: AppExTheme.bodySmall(context),
            ),
          ],
        ),
      ),
    );
  }
}
