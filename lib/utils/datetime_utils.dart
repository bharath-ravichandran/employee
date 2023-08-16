import 'package:intl/intl.dart';

extension DateTimeUtil on DateTime {
  /// Generate a new DateTime instance with a zero time.
  DateTime toZeroTime() => DateTime.utc(year, month, day, 12);

  int findWeekIndex(List<DateTime> dates) {
    return dates.indexWhere(isAtSameMomentAs) ~/ 7;
  }

  /// Calculates first week date (Sunday) from this date.
  DateTime firstDayOfWeek({int? startWeekDay}) {
    final utcDate = DateTime.utc(year, month, day, 12);
    if (startWeekDay != null && startWeekDay < 7) {
      return utcDate.subtract(Duration(days: utcDate.weekday - startWeekDay));
    }
    return utcDate.subtract(Duration(days: utcDate.weekday % 7));
  }

  /// Generates 7 dates according to this date.
  /// (Supposed that this date is result of [firstDayOfWeek])
  List<DateTime> weekDates() {
    return List.generate(
      7,
      (index) => add(Duration(days: index)),
      growable: false,
    );
  }

  /// Generates list of list with [DateTime]
  /// according to [date] and [weeksAmount].
  /// gives the beginning of the day of the week [startWeekDay]
  List<List<DateTime>> generateWeeks(int weeksAmount, {int? startWeekDay}) {
    final firstViewDate = firstDayOfWeek(startWeekDay: startWeekDay).subtract(
      Duration(
        days: (weeksAmount ~/ 2) * 7,
      ),
    );

    return List.generate(
      weeksAmount,
      (weekIndex) {
        final firstDateOfNextWeek = firstViewDate.add(
          Duration(
            days: weekIndex * 7,
          ),
        );

        return firstDateOfNextWeek.weekDates();
      },
      growable: false,
    );
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String toFormat() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }
}

extension DateTimeUtilInt on int {
  String toDate() {
    if (this == 0) {
      return 'Sun';
    } else if (this == 1) {
      return 'Mon';
    } else if (this == 2) {
      return 'Tue';
    } else if (this == 3) {
      return 'Wed';
    } else if (this == 4) {
      return 'Thu';
    } else if (this == 5) {
      return 'Fri';
    } else {
      return 'Sat';
    }
  }

  String toMonth() {
    if (this == 1) {
      return 'January';
    } else if (this == 2) {
      return 'February';
    } else if (this == 3) {
      return 'March';
    } else if (this == 4) {
      return 'April';
    } else if (this == 5) {
      return 'May';
    } else if (this == 6) {
      return 'June';
    } else if (this == 7) {
      return 'July';
    } else if (this == 8) {
      return 'August';
    } else if (this == 9) {
      return 'September';
    } else if (this == 10) {
      return 'October';
    } else if (this == 11) {
      return 'November';
    } else {
      return 'December';
    }
  }
}
