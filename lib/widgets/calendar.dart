import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/utils/helper.dart';
import 'package:period_track/widgets/calendar_header.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/preferences.dart';
import '../utils/constants.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    var keyedNotes = {for (var e in notes) e.date: e};

    List<Event> _getEventsFromNotes(DateTime day) {
      var key = DateUtils.dateOnly(day);

      if (keyedNotes.containsKey(key) == false) {
        return [];
      }

      if (keyedNotes[key]?.intimacy ?? false) {
        return [const Event('Note'), const Event('Intimacy')];
      }

      return [const Event('Note')];
    }

    return SizedBox(
      width: 600,
      child: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return Text(
                _focusedDay.value.year.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  color: const Color(0xffFFBB7C),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.12,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          notes.isEmpty
              ? const Text(
                  'Looks like you have not recorded a period yet. Add a new note or click on a day to get started.',
                  style: TextStyle(color: textColor))
              : const SizedBox(),
          const Divider(color: Color(0xffFFBB7C)),
          const SizedBox(height: 8),
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return CalendarHeader(
                focusedDay: _focusedDay.value,
                onLeftArrowTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onRightArrowTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              );
            },
          ),
          const SizedBox(height: 8),
          TableCalendar(
            daysOfWeekVisible: false,
            headerVisible: false,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2100, 01, 01),
            focusedDay: _focusedDay.value,
            eventLoader: _getEventsFromNotes,
            onDaySelected: (day, day2) {
              navigatorKey.currentState!.pushNamed('/add-note', arguments: { "id": DateUtils.dateOnly(day).toIso8601String() });
            },
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, day2) {
                return CalendarDay(day: day, day2: day2);
              },
              defaultBuilder: (context, day, day2) {
                return CalendarDay(day: day, day2: day2);
              },
              disabledBuilder: (context, day, day2) {
                return const Center();
              },
              withinRangeBuilder: (context, day, day2) {
                return const Center();
              },
              outsideBuilder: (context, day, day2) {
                return const Center();
              },
              rangeHighlightBuilder: (context, day, isWithinRange) {
                return const Center();
              },
              rangeStartBuilder: (context, day, day2) {
                return const Center();
              },
              rangeEndBuilder: (context, day, day2) {
                return const Center();
              },
              markerBuilder: (context, day, list) {
                List<Widget> dots = [];

                // Not sure why the logic is this way but don't show event on non-current month
                if (day.month == _focusedDay.value.month) {
                  return const Center();
                }

                for (var element in list) {
                  dots.add(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 2),
                      child: CircleAvatar(
                          backgroundColor: element == const Event('Note')
                              ? const Color(0xffFFBB7C)
                              : const Color(0xffECCDD6),
                          maxRadius: 4),
                    ),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dots,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  CalendarDay({Key? key, required this.day, required this.day2})
      : super(key: key);
  final DateTime day;
  final DateTime day2;

  final calendarTextStyle = GoogleFonts.josefinSans(
    color: textColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.05,
  );

  @override
  Widget build(BuildContext context) {
    var dateOnly = DateUtils.dateOnly(day);

    var notes = Provider.of<Iterable<NoteModel>>(context).toList();
    var preferences = Provider.of<Preferences>(context);

    if (day.month != day2.month) {
      return const Center();
    }

    if (notes.isEmpty) {
      return Center(child: Text(day.day.toString(), style: calendarTextStyle));
    }

    var periodStartNotes =
        notes.where((element) => element.periodStart).toList();

    int menstrualCycleLength =
        computeMenstrualLength(preferences.defaultCycleLength, periodStartNotes.map((e) => e.date).toList());
    int periodLength = computePeriodLength(menstrualCycleLength);
    int ovulationLength = (menstrualCycleLength / 2).ceil();
    int fertileLength = (menstrualCycleLength / 3).ceil();

    List<DateTime> periodStartDate =
        periodStartNotes.map((e) => e.date).toList();
    List<DateTime> periodEndDate = periodStartDate
        .map((e) => e.add(Duration(days: periodLength)))
        .toList();
    List<DateTime> ovulationDate = periodStartDate
        .map((e) => e.add(Duration(days: ovulationLength)))
        .toList();
    List<DateTime> fertilePeriodDateStart = periodStartDate
        .map((e) => e.add(Duration(days: fertileLength)))
        .toList();
    Map<DateTime, DateTime> predictedPeriodDays = computeNextFewYearsOfCycles(menstrualCycleLength, periodStartDate.first);

    if (periodStartDate.contains(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xffFFBB7C))),
          child: CircleAvatar(
            backgroundColor: primaryDarkColor,
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (ovulationDate.contains(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xffE3E3A7))),
          child: CircleAvatar(
            backgroundColor: const Color(0xff989859),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < periodStartDate.length; ++i) {
      if (dateOnly.isAfter(periodStartDate[i].add(const Duration(days: -1))) &&
          dateOnly.isBefore(periodEndDate[i])) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xffFFBB7C))),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        );
      }
    }

    for (var i = 0; i < ovulationDate.length; ++i) {
      if (dateOnly.isAfter(fertilePeriodDateStart[i]) &&
          dateOnly.isBefore(ovulationDate[i].add(const Duration(days: 2)))) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xffE3E3A7))),
            child: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: calendarTextStyle,
                ),
              ),
            ),
          ),
        );
      }
    }

    if (predictedPeriodDays.containsKey(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xffECCDD6))),
          child: SizedBox(
            height: 20,
            width: 20,
            child: Center(
              child: Text(
                day.day.toString(),
                style: calendarTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    return Center(child: Text(day.day.toString(), style: calendarTextStyle));
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
