import 'package:flutter/widgets.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:table_calendar/src/table_calendar.dart';
import '../table_calendar.dart';
import 'shared/date_utils.dart';
import 'shared/utils.dart';


class Calendar<T> extends TableCalendar<T> {

  Calendar({
    Key? key,
    DateTime? focusedDay,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? currentDay,
    locale,
    DateTime? rangeStartDay,
    DateTime? rangeEndDay,
    List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
    CalendarFormat calendarFormat = CalendarFormat.month,
    Map<CalendarFormat, String> availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week',
    },
    bool headerVisible = true,
    bool daysOfWeekVisible = true,
    bool pageJumpingEnabled = false,
    bool pageAnimationEnabled = true,
    bool sixWeekMonthsEnforced = false,
    bool shouldFillViewport = false,
    double rowHeight = 52.0,
    double daysOfWeekHeight = 16.0,
    Duration formatAnimationDuration = const Duration(milliseconds: 200),
    Curve formatAnimationCurve = Curves.linear,
    Duration pageAnimationDuration = const Duration(milliseconds: 300),
    pageAnimationCurve = Curves.easeOut,
    StartingDayOfWeek startingDayOfWeek = StartingDayOfWeek.monday,
    HitTestBehavior dayHitTestBehavior = HitTestBehavior.opaque,
    AvailableGestures availableGestures = AvailableGestures.horizontalSwipe,
    SimpleSwipeConfig simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    HeaderStyle headerStyle = const HeaderStyle(),
    DaysOfWeekStyle daysOfWeekStyle = const DaysOfWeekStyle(),
    CalendarStyle calendarStyle = const CalendarStyle(),
    CalendarBuilders<T> calendarBuilders = const CalendarBuilders(),
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff,
    List<T> Function(DateTime day)? eventLoader,
    bool Function(DateTime day)? enabledDayPredicate,
    bool Function(DateTime day)? selectedDayPredicate,
    bool Function(DateTime day)? holidayPredicate,
    OnRangeSelected? onRangeSelected,
    OnDaySelected? onDaySelected,
    OnDaySelected? onDayLongPressed,
    void Function(DateTime day)? onDisabledDayTapped,
    void Function(DateTime day)? onDisabledDayLongPressed,
    void Function(DateTime focusedDay)? onHeaderTapped,
    void Function(DateTime focusedDay)? onHeaderLongPressed,
    void Function(DateTime focusedDay)? onPageChanged,
    void Function(CalendarFormat format)? onFormatChanged,
    void Function(PageController pageController)? onCalendarCreated,
  }) : super(
      key: key,
      focusedDay: focusedDay ?? DateTime.now(),
      firstDay: firstDay ?? DateTime(DateTime.now().year - 10),
      lastDay: lastDay ?? DateTime(DateTime.now().year + 10),

      locale: locale,
      rangeStartDay: rangeStartDay,
      rangeEndDay: rangeEndDay,
      weekendDays: weekendDays,
      calendarFormat: calendarFormat,
      availableCalendarFormats: availableCalendarFormats,
      headerVisible: headerVisible,
      daysOfWeekVisible: daysOfWeekVisible,
      pageJumpingEnabled: pageJumpingEnabled,
      pageAnimationEnabled: pageAnimationEnabled,
      sixWeekMonthsEnforced: sixWeekMonthsEnforced,
      shouldFillViewport: shouldFillViewport,
      rowHeight: rowHeight,
      daysOfWeekHeight: daysOfWeekHeight,
      formatAnimationDuration: formatAnimationDuration,
      formatAnimationCurve: formatAnimationCurve,
      pageAnimationDuration: pageAnimationDuration,
      pageAnimationCurve: pageAnimationCurve,
    startingDayOfWeek: startingDayOfWeek,
    dayHitTestBehavior: dayHitTestBehavior,
    availableGestures: availableGestures,
      simpleSwipeConfig: simpleSwipeConfig,
      headerStyle: headerStyle,
      daysOfWeekStyle: daysOfWeekStyle,
      calendarStyle: calendarStyle,
      calendarBuilders: calendarBuilders,
      rangeSelectionMode: rangeSelectionMode,
      eventLoader: eventLoader,
      enabledDayPredicate: enabledDayPredicate,
      selectedDayPredicate: selectedDayPredicate,
      holidayPredicate: holidayPredicate,
      onRangeSelected: onRangeSelected,
      onDaySelected: onDaySelected,
      onDayLongPressed: onDayLongPressed,
      onDisabledDayTapped: onDisabledDayTapped,
      onDisabledDayLongPressed: onDisabledDayLongPressed,
      onHeaderTapped: onHeaderTapped,
      onHeaderLongPressed: onHeaderLongPressed,
      onPageChanged: onPageChanged,
      onFormatChanged: onFormatChanged,
    onCalendarCreated: onCalendarCreated,
  );

  Calendar.month({
    Key? key,
    required DateTime monthDay,
    DateTime? focusedDay,
    DateTime? currentDay,
    locale,
    DateTime? rangeStartDay,
    DateTime? rangeEndDay,
    List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
    Map<CalendarFormat, String> availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week',
    },
    bool headerVisible = false,
    bool daysOfWeekVisible = true,
    bool pageJumpingEnabled = false,
    bool pageAnimationEnabled = true,
    bool sixWeekMonthsEnforced = false,
    bool shouldFillViewport = false,
    double rowHeight = 52.0,
    double daysOfWeekHeight = 16.0,
    Duration formatAnimationDuration = const Duration(milliseconds: 200),
    Curve formatAnimationCurve = Curves.linear,
    Duration pageAnimationDuration = const Duration(milliseconds: 300),
    pageAnimationCurve = Curves.easeOut,
    StartingDayOfWeek startingDayOfWeek = StartingDayOfWeek.sunday,
    HitTestBehavior dayHitTestBehavior = HitTestBehavior.opaque,
    AvailableGestures availableGestures = AvailableGestures.none,
    SimpleSwipeConfig simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    HeaderStyle headerStyle = const HeaderStyle(),
    DaysOfWeekStyle daysOfWeekStyle = const DaysOfWeekStyle(),
    CalendarStyle calendarStyle = const CalendarStyle(),
    CalendarBuilders<T> calendarBuilders = const CalendarBuilders(),
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff,
    List<T> Function(DateTime day)? eventLoader,
    bool Function(DateTime day)? enabledDayPredicate,
    bool Function(DateTime day)? selectedDayPredicate,
    bool Function(DateTime day)? holidayPredicate,
    OnRangeSelected? onRangeSelected,
    OnDaySelected? onDaySelected,
    OnDaySelected? onDayLongPressed,
    void Function(DateTime day)? onDisabledDayTapped,
    void Function(DateTime day)? onDisabledDayLongPressed,
    void Function(DateTime focusedDay)? onHeaderTapped,
    void Function(DateTime focusedDay)? onHeaderLongPressed,
    void Function(DateTime focusedDay)? onPageChanged,
    void Function(CalendarFormat format)? onFormatChanged,
    void Function(PageController pageController)? onCalendarCreated,
  }): this(
    key: key,
    focusedDay: focusedDay ?? DateTime.now(),
    firstDay: firstDayOfMonth(monthDay),
    lastDay: lastDayOfMonth(monthDay),
    calendarFormat: CalendarFormat.month,

    locale: locale,
    rangeStartDay: rangeStartDay,
    rangeEndDay: rangeEndDay,
    weekendDays: weekendDays,
    availableCalendarFormats: availableCalendarFormats,
    headerVisible: headerVisible,
    daysOfWeekVisible: daysOfWeekVisible,
    pageJumpingEnabled: pageJumpingEnabled,
    pageAnimationEnabled: pageAnimationEnabled,
    sixWeekMonthsEnforced: sixWeekMonthsEnforced,
    shouldFillViewport: shouldFillViewport,
    rowHeight: rowHeight,
    daysOfWeekHeight: daysOfWeekHeight,
    formatAnimationDuration: formatAnimationDuration,
    formatAnimationCurve: formatAnimationCurve,
    pageAnimationDuration: pageAnimationDuration,
    pageAnimationCurve: pageAnimationCurve,
    startingDayOfWeek: startingDayOfWeek,
    dayHitTestBehavior: dayHitTestBehavior,
    availableGestures: availableGestures,
    simpleSwipeConfig: simpleSwipeConfig,
    headerStyle: headerStyle,
    daysOfWeekStyle: daysOfWeekStyle,
    calendarStyle: calendarStyle,
    calendarBuilders: calendarBuilders,
    rangeSelectionMode: rangeSelectionMode,
    eventLoader: eventLoader,
    enabledDayPredicate: enabledDayPredicate,
    selectedDayPredicate: selectedDayPredicate,
    holidayPredicate: holidayPredicate,
    onRangeSelected: onRangeSelected,
    onDaySelected: onDaySelected,
    onDayLongPressed: onDayLongPressed,
    onDisabledDayTapped: onDisabledDayTapped,
    onDisabledDayLongPressed: onDisabledDayLongPressed,
    onHeaderTapped: onHeaderTapped,
    onHeaderLongPressed: onHeaderLongPressed,
    onPageChanged: onPageChanged,
    onFormatChanged: onFormatChanged,
    onCalendarCreated: onCalendarCreated,
  );

  Calendar.week({
    Key? key,
    required DateTime weekDay,
    DateTime? focusedDay,
    DateTime? currentDay,
    locale,
    DateTime? rangeStartDay,
    DateTime? rangeEndDay,
    List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
    Map<CalendarFormat, String> availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.twoWeeks: '2 weeks',
      CalendarFormat.week: 'Week',
    },
    bool headerVisible = false,
    bool daysOfWeekVisible = true,
    bool pageJumpingEnabled = false,
    bool pageAnimationEnabled = true,
    bool sixWeekMonthsEnforced = false,
    bool shouldFillViewport = false,
    double rowHeight = 52.0,
    double daysOfWeekHeight = 16.0,
    Duration formatAnimationDuration = const Duration(milliseconds: 200),
    Curve formatAnimationCurve = Curves.linear,
    Duration pageAnimationDuration = const Duration(milliseconds: 300),
    pageAnimationCurve = Curves.easeOut,
    StartingDayOfWeek startingDayOfWeek = StartingDayOfWeek.monday,
    HitTestBehavior dayHitTestBehavior = HitTestBehavior.opaque,
    AvailableGestures availableGestures = AvailableGestures.none,
    SimpleSwipeConfig simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    HeaderStyle headerStyle = const HeaderStyle(),
    DaysOfWeekStyle daysOfWeekStyle = const DaysOfWeekStyle(),
    CalendarStyle calendarStyle = const CalendarStyle(),
    CalendarBuilders<T> calendarBuilders = const CalendarBuilders(),
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff,
    List<T> Function(DateTime day)? eventLoader,
    bool Function(DateTime day)? enabledDayPredicate,
    bool Function(DateTime day)? selectedDayPredicate,
    bool Function(DateTime day)? holidayPredicate,
    OnRangeSelected? onRangeSelected,
    OnDaySelected? onDaySelected,
    OnDaySelected? onDayLongPressed,
    void Function(DateTime day)? onDisabledDayTapped,
    void Function(DateTime day)? onDisabledDayLongPressed,
    void Function(DateTime focusedDay)? onHeaderTapped,
    void Function(DateTime focusedDay)? onHeaderLongPressed,
    void Function(DateTime focusedDay)? onPageChanged,
    void Function(CalendarFormat format)? onFormatChanged,
    void Function(PageController pageController)? onCalendarCreated,
  }): this(
    key: key,
    focusedDay: focusedDay ?? DateTime.now(),
    firstDay: firstDayOfWeek(weekDay, startingDayOfWeek),
    lastDay: firstDayOfWeek(weekDay, startingDayOfWeek).subtract(Duration(days: -6)),
    calendarFormat: CalendarFormat.week,

    locale: locale,
    rangeStartDay: rangeStartDay,
    rangeEndDay: rangeEndDay,
    weekendDays: weekendDays,
    availableCalendarFormats: availableCalendarFormats,
    headerVisible: headerVisible,
    daysOfWeekVisible: daysOfWeekVisible,
    pageJumpingEnabled: pageJumpingEnabled,
    pageAnimationEnabled: pageAnimationEnabled,
    sixWeekMonthsEnforced: sixWeekMonthsEnforced,
    shouldFillViewport: shouldFillViewport,
    rowHeight: rowHeight,
    daysOfWeekHeight: daysOfWeekHeight,
    formatAnimationDuration: formatAnimationDuration,
    formatAnimationCurve: formatAnimationCurve,
    pageAnimationDuration: pageAnimationDuration,
    pageAnimationCurve: pageAnimationCurve,
    startingDayOfWeek: startingDayOfWeek,
    dayHitTestBehavior: dayHitTestBehavior,
    availableGestures: availableGestures,
    simpleSwipeConfig: simpleSwipeConfig,
    headerStyle: headerStyle,
    daysOfWeekStyle: daysOfWeekStyle,
    calendarStyle: calendarStyle,
    calendarBuilders: calendarBuilders,
    rangeSelectionMode: rangeSelectionMode,
    eventLoader: eventLoader,
    enabledDayPredicate: enabledDayPredicate,
    selectedDayPredicate: selectedDayPredicate,
    holidayPredicate: holidayPredicate,
    onRangeSelected: onRangeSelected,
    onDaySelected: onDaySelected,
    onDayLongPressed: onDayLongPressed,
    onDisabledDayTapped: onDisabledDayTapped,
    onDisabledDayLongPressed: onDisabledDayLongPressed,
    onHeaderTapped: onHeaderTapped,
    onHeaderLongPressed: onHeaderLongPressed,
    onPageChanged: onPageChanged,
    onFormatChanged: onFormatChanged,
    onCalendarCreated: onCalendarCreated,
  );


}