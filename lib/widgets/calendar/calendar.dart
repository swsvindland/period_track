import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/utils/helper.dart';
import 'package:period_track/widgets/calendar/calendar_header.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/preferences.dart';
import '../../utils/constants.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    var keyedNotes = {for (var e in notes) e.date: e};

    List<Event> _getEventsFromNotes(DateTime day) {
      var key = DateUtils.dateOnly(day);
      List<Event> events = [];

      if (keyedNotes.containsKey(key) == false) {
        return [];
      }

      events.add(const Event('Note'));

      if (keyedNotes[key]?.intimacy ?? false) {
        events.add(const Event('Intimacy'));
      }

      if (keyedNotes[key]?.flow == FlowRate.light) {
        events.add(const Event('Light'));
      }

      if (keyedNotes[key]?.flow == FlowRate.normal) {
        events.add(const Event('Normal'));
      }

      if (keyedNotes[key]?.flow == FlowRate.heavy) {
        events.add(const Event('Heavy'));
      }

      return events;
    }

    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Text(
            _focusedDay.year.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.josefinSans(
              color: textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.12,
            ),
          ),
          const SizedBox(height: 24),
          notes.isEmpty
              ? const Text(
                  'Looks like you have not recorded a period yet. Add a new note or click on a day to get started.',
                  style: TextStyle(color: text))
              : const SizedBox(),
          const Divider(color: secondary),
          const SizedBox(height: 8),
          CalendarHeader(
            focusedDay: _focusedDay,
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
          ),
          const SizedBox(height: 8),
          TableCalendar(
            daysOfWeekVisible: false,
            headerVisible: false,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2100, 01, 01),
            focusedDay: _focusedDay,
            eventLoader: _getEventsFromNotes,
            onDaySelected: (day, day2) {
              navigatorKey.currentState!.pushNamed('/add-note',
                  arguments: {"id": DateUtils.dateOnly(day).toIso8601String()});
            },
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) => {
              setState(() {
                _focusedDay = focusedDay;
              })
            },
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

                if (day.month != _focusedDay.month ||
                    day.year != _focusedDay.year) {
                  return const Center();
                }

                for (var element in list) {
                  if (element == const Event('Note')) {
                    dots.add(
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 2),
                        child: CircleAvatar(
                          backgroundColor: secondary,
                          maxRadius: 4,
                        ),
                      ),
                    );
                  }

                  if (element == const Event('Intimacy')) {
                    dots.add(
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 2),
                        child: CircleAvatar(
                          backgroundColor: primaryLight,
                          maxRadius: 4,
                        ),
                      ),
                    );
                  }

                  if (element == const Event('Light')) {
                    dots.add(
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 2),
                        child: CircleAvatar(
                          backgroundColor: primaryDark,
                          maxRadius: 4,
                        ),
                      ),
                    );
                  }

                  if (element == const Event('Normal')) {
                    dots.add(
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 2),
                        child: Row(
                          children: const [
                            CircleAvatar(
                              backgroundColor: primaryDark,
                              maxRadius: 4,
                            ),
                            CircleAvatar(
                              backgroundColor: primaryDark,
                              maxRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (element == const Event('Heavy')) {
                    dots.add(
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 2),
                        child: Row(
                          children: const [
                            CircleAvatar(
                              backgroundColor: primaryDark,
                              maxRadius: 4,
                            ),
                            CircleAvatar(
                              backgroundColor: primaryDark,
                              maxRadius: 4,
                            ),
                            CircleAvatar(
                              backgroundColor: primaryDark,
                              maxRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
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
    color: text,
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

    var keyedNotes = {for (var e in notes) e.date: e};

    var periodStartNotes =
        notes.where((element) => element.periodStart).toList();

    periodStartNotes.sort((a, b) => a.date.compareTo(b.date));

    int menstrualCycleLength = computeMenstrualLength(
        preferences.defaultCycleLength,
        periodStartNotes.map((e) => e.date).toList());
    int ovulationLength = computeOvulationLength(menstrualCycleLength);
    int fertileLength = computeFertilityLength(menstrualCycleLength);

    List<DateTime> periodStartDate =
        periodStartNotes.map((e) => e.date).toList();
    List<DateTime> ovulationDate = periodStartDate
        .map((e) => e.add(Duration(days: ovulationLength)))
        .toList();
    List<DateTime> fertilePeriodDateStart = periodStartDate
        .map((e) => e.add(Duration(days: fertileLength)))
        .toList();
    Map<DateTime, DateTime> predictedPeriodDays =
        computeNextFewYearsOfCycles(menstrualCycleLength, periodStartDate);

    if (periodStartDate.contains(dateOnly)) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: secondary)),
          child: CircleAvatar(
            backgroundColor: primaryDark,
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
              shape: BoxShape.circle, border: Border.all(color: ternaryLight)),
          child: CircleAvatar(
            backgroundColor: ternary,
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

    if (keyedNotes.containsKey(DateUtils.dateOnly(day))) {
      if (keyedNotes[DateUtils.dateOnly(day)]?.flow != null) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: secondary)),
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
                border: Border.all(color: ternaryLight)),
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
              shape: BoxShape.circle, border: Border.all(color: primaryLight)),
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
