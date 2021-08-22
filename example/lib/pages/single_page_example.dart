// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class SinglePageExample extends StatefulWidget {
  @override
  _SinglePageExampleState createState() => _SinglePageExampleState();
}

class _SinglePageExampleState extends State<SinglePageExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final visibleDays = CalendarDateBuilder(DateTime.now()).getDays();
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: SingleChildScrollView(child: Column(children: [
        CalendarPage(dowVisible: false, visibleDays: visibleDays, dayBuilder: (context, day) {
          return SizedBox(
            height: 30,
            child: Text(day.day.toString()),
          );
        }),
        SizedBox(height: 50,),
        Calendar.month(monthDay: DateTime.now()),
        SizedBox(height: 50,),
        Calendar.week(weekDay: DateTime.now()),
        SizedBox(height: 50,),
      ],),),
    );
  }
}
