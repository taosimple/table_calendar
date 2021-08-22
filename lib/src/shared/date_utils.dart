

int getDaysBefore(DateTime firstDay, StartingDayOfWeek startingDayOfWeek) {
  return (firstDay.weekday + 7 - getWeekdayNumber(startingDayOfWeek)) % 7;
}

int getDaysAfter(DateTime lastDay, StartingDayOfWeek startingDayOfWeek) {
  int invertedStartingWeekday = 8 - getWeekdayNumber(startingDayOfWeek);

  int daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7);
  if (daysAfter == 7) {
    daysAfter = 0;
  }

  return daysAfter;
}

DateTime firstDayOfWeek(DateTime week, StartingDayOfWeek startingDayOfWeek) {
  final daysBefore = getDaysBefore(week, startingDayOfWeek);
  return week.subtract(Duration(days: daysBefore));
}

DateTime firstDayOfMonth(DateTime month) {
  return DateTime.utc(month.year, month.month, 1);
}

DateTime lastDayOfMonth(DateTime month) {
  final date = month.month < 12
      ? DateTime.utc(month.year, month.month + 1, 1)
      : DateTime.utc(month.year + 1, 1, 1);
  return date.subtract(const Duration(days: 1));
}

/// Days of the week that the calendar can start with.
enum StartingDayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

/// Returns a numerical value associated with given `weekday`.
///
/// Returns 1 for `StartingDayOfWeek.monday`, all the way to 7 for `StartingDayOfWeek.sunday`.
int getWeekdayNumber(StartingDayOfWeek weekday) {
  return StartingDayOfWeek.values.indexOf(weekday) + 1;
}
