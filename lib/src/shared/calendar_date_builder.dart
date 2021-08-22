import 'package:flutter/material.dart';
import 'date_utils.dart';
import 'utils.dart';


class CalendarDateBuilder {

  final StartingDayOfWeek startingDayOfWeek;
  final bool sixWeekMonthsEnforced;
  final CalendarFormat format;
  final DateTime baseDay;

  CalendarDateBuilder(this.baseDay, {
    this.startingDayOfWeek = StartingDayOfWeek.monday,
    this.format = CalendarFormat.month,
    this.sixWeekMonthsEnforced = false
  });

  List<DateTime> getDays(){
    final visibleRange = _getVisibleRange(format, baseDay);
    final visibleDays = _daysInRange(visibleRange.start, visibleRange.end);
    return visibleDays;
  }

  DateTimeRange _getVisibleRange(CalendarFormat format, DateTime focusedDay) {
    switch (format) {
      case CalendarFormat.month:
        return _daysInMonth(focusedDay);
      case CalendarFormat.twoWeeks:
        return _daysInTwoWeeks(focusedDay);
      case CalendarFormat.week:
        return _daysInWeek(focusedDay);
      default:
        return _daysInMonth(focusedDay);
    }
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
          (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  DateTimeRange _daysInWeek(DateTime focusedDay) {
    final daysBefore = getDaysBefore(focusedDay, startingDayOfWeek);
    final firstToDisplay = focusedDay.subtract(Duration(days: daysBefore));
    final lastToDisplay = firstToDisplay.add(const Duration(days: 7));
    return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
  }

  DateTimeRange _daysInTwoWeeks(DateTime focusedDay) {
    final daysBefore = getDaysBefore(focusedDay, startingDayOfWeek);
    final firstToDisplay = focusedDay.subtract(Duration(days: daysBefore));
    final lastToDisplay = firstToDisplay.add(const Duration(days: 14));
    return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
  }

  DateTimeRange _daysInMonth(DateTime focusedDay) {
    final first = firstDayOfMonth(focusedDay);
    final daysBefore = getDaysBefore(first, startingDayOfWeek);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    if (sixWeekMonthsEnforced) {
      final end = firstToDisplay.add(const Duration(days: 42));
      return DateTimeRange(start: firstToDisplay, end: end);
    }

    final last = lastDayOfMonth(focusedDay);
    final daysAfter = getDaysAfter(last, startingDayOfWeek);
    final lastToDisplay = last.add(Duration(days: daysAfter));

    return DateTimeRange(start: firstToDisplay, end: lastToDisplay);
  }

  int getRowCount(CalendarFormat format, DateTime focusedDay) {
    if (format == CalendarFormat.twoWeeks) {
      return 2;
    } else if (format == CalendarFormat.week) {
      return 1;
    } else if (sixWeekMonthsEnforced) {
      return 6;
    }

    final first = firstDayOfMonth(focusedDay);
    final daysBefore = getDaysBefore(first, startingDayOfWeek);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    final last = lastDayOfMonth(focusedDay);
    final daysAfter = getDaysAfter(last, startingDayOfWeek);
    final lastToDisplay = last.add(Duration(days: daysAfter));

    return (lastToDisplay.difference(firstToDisplay).inDays + 1) ~/ 7;
  }



}