// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:table_calendar/src/shared/calendar_date_builder.dart';
import 'package:table_calendar/src/shared/date_utils.dart';

import '../shared/utils.dart';
import 'calendar_page.dart';

typedef _OnCalendarPageChanged = void Function(
    int pageIndex, DateTime focusedDay);

class CalendarCore extends StatelessWidget {
  final DateTime? focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final CalendarFormat calendarFormat;
  final DayBuilder? dowBuilder;
  final FocusedDayBuilder dayBuilder;
  final bool sixWeekMonthsEnforced;
  final bool dowVisible;
  final Decoration? dowDecoration;
  final Decoration? rowDecoration;
  final double? dowHeight;
  final double? rowHeight;
  final BoxConstraints constraints;
  final int? previousIndex;
  final StartingDayOfWeek startingDayOfWeek;
  final PageController? pageController;
  final ScrollPhysics? scrollPhysics;
  final _OnCalendarPageChanged onPageChanged;

  const CalendarCore({
    Key? key,
    this.dowBuilder,
    required this.dayBuilder,
    required this.onPageChanged,
    required this.firstDay,
    required this.lastDay,
    required this.constraints,
    this.dowHeight,
    this.rowHeight,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.calendarFormat = CalendarFormat.month,
    this.pageController,
    this.focusedDay,
    this.previousIndex,
    this.sixWeekMonthsEnforced = false,
    this.dowVisible = true,
    this.dowDecoration,
    this.rowDecoration,
    this.scrollPhysics,
  })  : assert(!dowVisible || (dowHeight != null && dowBuilder != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: scrollPhysics,
      itemCount: _getPageCount(calendarFormat, firstDay, lastDay),
      itemBuilder: (context, index) {
        final baseDay = _getBaseDay(calendarFormat, index);
        final calendarDateBuilder = CalendarDateBuilder(
          baseDay,
          startingDayOfWeek: startingDayOfWeek,
          format: calendarFormat,
          sixWeekMonthsEnforced: sixWeekMonthsEnforced,
        );
        final visibleDays = calendarDateBuilder.getDays();
        final actualDowHeight = dowVisible ? dowHeight! : 0.0;
        final constrainedRowHeight = constraints.hasBoundedHeight
            ? (constraints.maxHeight - actualDowHeight) /
            calendarDateBuilder.getRowCount(calendarFormat, baseDay)
            : null;

        return CalendarPage(
          visibleDays: visibleDays,
          dowVisible: dowVisible,
          dowDecoration: dowDecoration,
          rowDecoration: rowDecoration,
          dowBuilder: (context, day) {
            return SizedBox(
              height: dowHeight,
              child: dowBuilder?.call(context, day),
            );
          },
          dayBuilder: (context, day) {
            DateTime baseDay;
            final previousFocusedDay = focusedDay;
            if (previousFocusedDay == null || previousIndex == null) {
              baseDay = _getBaseDay(calendarFormat, index);
            } else {
              baseDay = _getFocusedDay(calendarFormat, previousFocusedDay, index);
            }

            return SizedBox(
              height: constrainedRowHeight ?? rowHeight,
              child: dayBuilder(context, day, baseDay),
            );
          },
        );
      },
      onPageChanged: (index) {
        DateTime baseDay;
        final previousFocusedDay = focusedDay;
        if (previousFocusedDay == null || previousIndex == null) {
          baseDay = _getBaseDay(calendarFormat, index);
        } else {
          baseDay = _getFocusedDay(calendarFormat, previousFocusedDay, index);
        }

        return onPageChanged(index, baseDay);
      },
    );
  }

  int _getPageCount(CalendarFormat format, DateTime first, DateTime last) {
    switch (format) {
      case CalendarFormat.month:
        return _getMonthCount(first, last) + 1;
      case CalendarFormat.twoWeeks:
        return _getTwoWeekCount(first, last) + 1;
      case CalendarFormat.week:
        return _getWeekCount(first, last) + 1;
      default:
        return _getMonthCount(first, last) + 1;
    }
  }

  int _getMonthCount(DateTime first, DateTime last) {
    final yearDif = last.year - first.year;
    final monthDif = last.month - first.month;

    return yearDif * 12 + monthDif;
  }

  int _getWeekCount(DateTime first, DateTime last) {
    return last.difference(firstDayOfWeek(first, startingDayOfWeek)).inDays ~/ 7;
  }

  int _getTwoWeekCount(DateTime first, DateTime last) {
    return last.difference(firstDayOfWeek(first, startingDayOfWeek)).inDays ~/ 14;
  }

  DateTime _getFocusedDay(
      CalendarFormat format, DateTime prevFocusedDay, int pageIndex) {
    if (pageIndex == previousIndex) {
      return prevFocusedDay;
    }

    final pageDif = pageIndex - previousIndex!;
    DateTime day;

    switch (format) {
      case CalendarFormat.month:
        day = DateTime.utc(prevFocusedDay.year, prevFocusedDay.month + pageDif);
        break;
      case CalendarFormat.twoWeeks:
        day = DateTime.utc(prevFocusedDay.year, prevFocusedDay.month,
            prevFocusedDay.day + pageDif * 14);
        break;
      case CalendarFormat.week:
        day = DateTime.utc(prevFocusedDay.year, prevFocusedDay.month,
            prevFocusedDay.day + pageDif * 7);
        break;
    }

    if (day.isBefore(firstDay)) {
      day = firstDay;
    } else if (day.isAfter(lastDay)) {
      day = lastDay;
    }

    return day;
  }

  DateTime _getBaseDay(CalendarFormat format, int pageIndex) {
    DateTime day;

    switch (format) {
      case CalendarFormat.month:
        day = DateTime.utc(firstDay.year, firstDay.month + pageIndex);
        break;
      case CalendarFormat.twoWeeks:
        day = DateTime.utc(
            firstDay.year, firstDay.month, firstDay.day + pageIndex * 14);
        break;
      case CalendarFormat.week:
        day = DateTime.utc(
            firstDay.year, firstDay.month, firstDay.day + pageIndex * 7);
        break;
    }

    if (day.isBefore(firstDay)) {
      day = firstDay;
    } else if (day.isAfter(lastDay)) {
      day = lastDay;
    }

    return day;
  }

}
