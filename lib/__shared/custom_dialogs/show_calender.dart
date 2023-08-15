import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:employee/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_widgets/custom_cancel_button_widget.dart';

Future<void> showCalender(context, bool fromDate) {
  return showDialog(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: CalendarWidget(fromDate: fromDate),
            ),
          ),
        ],
      );
    },
  );
}

class CalendarWidget extends StatefulWidget {
  final bool fromDate;

  const CalendarWidget({
    super.key,
    required this.fromDate,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? selectedDate;
  DateTime shownDate = DateTime.now();
  late int startDate;

  @override
  void initState() {
    super.initState();
    startDate = DateTime(shownDate.year, shownDate.month, 1).weekday;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.fromDate) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppButton(
                  label: 'Today',
                  color: checkToday(selectedDate, DateTime.now()) ? Colors.blue : null,
                  onPressed: () {
                    var currentDate = DateTime.now();
                    var startDate = DateTime(currentDate.year, currentDate.month, 1).weekday;
                    selectedDate = DateTime(
                      currentDate.year,
                      currentDate.month,
                      currentDate.day - startDate + 2,
                    );
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  label: 'Next Monday',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppButton(
                  label: 'Next Monday',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  label: 'After 1 week',
                  color: checkToday(
                    selectedDate,
                    DateTime.now().add(
                      const Duration(days: 7),
                    ),
                  )
                      ? Colors.blue
                      : null,
                  onPressed: () {
                    var currentDate = DateTime.now();
                    var startDate = DateTime(currentDate.year, currentDate.month, 1).weekday;
                    selectedDate = DateTime(
                      currentDate.year,
                      currentDate.month,
                      currentDate.day + 7 - startDate + 2,
                    );
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ] else ...[
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'No Date',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  label: 'Today',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                shownDate = DateTime(
                  shownDate.year,
                  shownDate.month - 1,
                );
                startDate = DateTime(shownDate.year, shownDate.month, 1).weekday;
                setState(() {});
              },
              icon: const Icon(Icons.arrow_left),
            ),
            Text(
              '${shownDate.month.toMonth()} ${shownDate.year}',
              style: AppExTheme.titleSmall(context).copyWith(color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                shownDate = DateTime(
                  shownDate.year,
                  shownDate.month + 1,
                );
                startDate = DateTime(shownDate.year, shownDate.month, 1).weekday;
                setState(() {});
              },
              icon: const Icon(Icons.arrow_right),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
            (i) => SizedBox(
              width: 28,
              height: 20,
              child: Text(
                i.toDate(),
                style: AppExTheme.bodySmall(context),
                textAlign: TextAlign.center,
              ),
            ),
          ).toList(),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          children: List.generate(
            DateUtils.getDaysInMonth(
                  shownDate.year,
                  shownDate.month,
                ) +
                startDate,
            (i) => SizedBox(
              width: 28,
              height: 20,
              child: i >= startDate
                  ? Builder(builder: (_) {
                      var indexDay = i - startDate;

                      return InkWell(
                        onTap: () {
                          selectedDate = DateTime(
                            shownDate.year,
                            shownDate.month,
                            indexDay + 1,
                          );
                          print(selectedDate);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: getColor(selectedDate, shownDate, indexDay + 1),
                            border: Border.all(
                              color: getBorderColor(shownDate, DateTime.now(), indexDay),
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${indexDay + 1}',
                            style: AppExTheme.bodySmall(context).copyWith(
                              fontWeight: FontWeight.w100,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    })
                  : const SizedBox.shrink(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            SvgPicture.asset(AppIcons.calendar),
            const SizedBox(width: 20),
            Text(
              '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.employeeTextBlack,
                  ),
            ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
            AppButton(onPressed: () {}, label: 'Cancel'),
            const SizedBox(width: 16),
            AppButton(onPressed: () {}, label: 'Save')
          ],
        ),
      ],
    );
  }

  Color getColor(DateTime? selectedDate, DateTime currentDate, int y) {
    if (selectedDate != null) {
      if (selectedDate.year == currentDate.year) {
        if (selectedDate.month == currentDate.month) {
          if (selectedDate.day == y) {
            return Colors.blue;
          }
        }
      }
    }
    return Colors.transparent;
  }

  Color getBorderColor(DateTime? selectedDate, DateTime currentDate, indexDay) {
    if (selectedDate != null) {
      if (selectedDate.year == currentDate.year) {
        if (selectedDate.month == currentDate.month) {
          var currentDay = currentDate.day - startDate + 1;
          print('getBorderColor-selectedDate: $selectedDate');
          print('getBorderColor-currentDate: $currentDate');
          print('getBorderColor-indexDay: $currentDay');
          print('getBorderColor-currentDay: $currentDay');
          if (indexDay == currentDay) {
            return Colors.blue;
          }
        }
      }
    }
    return Colors.transparent;
  }

  bool checkToday(DateTime? selectedDate, DateTime currentDate) {
    print('checkToday-selectedDate: $selectedDate');
    print('checkToday-currentDate: $currentDate');

    if (selectedDate != null) {
      if (selectedDate.year == currentDate.year) {
        if (selectedDate.month == currentDate.month) {
          print('checkToday-currentDate: ${currentDate.day}');
          print('checkToday-selectedDate: ${selectedDate.day}');
          if (selectedDate.day == currentDate.day) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
