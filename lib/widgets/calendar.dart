import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/widgets/calendar_header.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/constants.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  final calendarTextStyle = GoogleFonts.josefinSans(
    color: textColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.05,
  );

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    var keyedNotes = {for (var e in notes) e.date: e};

    var periodStartNotes = notes.where((element) => element.periodStart);
    var periodsThisMonth = periodStartNotes.where((element) =>
        element.date.year == DateTime.now().year &&
        element.date.month == DateTime.now().month);

    // TODO: Compute this
    int menstrualCycleLength = 28;
    int periodLength = (menstrualCycleLength / 5).ceil();
    int ovulationLength = (menstrualCycleLength / 2).ceil();
    int fertileLength = (menstrualCycleLength / 3).ceil();

    List<DateTime> periodStartDate =
        periodsThisMonth.map((e) => e.date).toList();
    List<DateTime> periodEndDate = periodStartDate
        .map((e) => e.add(Duration(days: periodLength)))
        .toList();
    List<DateTime> ovulationDate = periodStartDate
        .map((e) => e.add(Duration(days: ovulationLength)))
        .toList();
    List<DateTime> fertilePeriodDateStart = periodStartDate
        .map((e) => e.add(Duration(days: fertileLength)))
        .toList();

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
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, day2) {
                var dateOnly = DateUtils.dateOnly(day);

                if (periodStartDate.contains(dateOnly)) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffFFBB7C))),
                      child: CircleAvatar(
                        backgroundColor: primaryDarkColor,
                        child: Text(
                          day.day.toString(),
                          style: calendarTextStyle,
                        ),
                      ),
                    ),
                  );
                }

                if (ovulationDate.contains(dateOnly)) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffE3E3A7))),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff989859),
                        child: Text(
                          day.day.toString(),
                          style: calendarTextStyle,
                        ),
                      ),
                    ),
                  );
                }

                return Center(
                    child: Text(day.day.toString(), style: calendarTextStyle));
              },
              defaultBuilder: (context, day, day2) {
                var dateOnly = DateUtils.dateOnly(day);

                if (periodStartDate.contains(dateOnly)) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffFFBB7C))),
                      child: CircleAvatar(
                        backgroundColor: primaryDarkColor,
                        child: Text(
                          day.day.toString(),
                          style: calendarTextStyle,
                        ),
                      ),
                    ),
                  );
                }

                if (ovulationDate.contains(dateOnly)) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffE3E3A7))),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff989859),
                        child: Text(
                          day.day.toString(),
                          style: calendarTextStyle,
                        ),
                      ),
                    ),
                  );
                }

                for (var i = 0; i < periodStartDate.length; ++i) {
                  if (dateOnly.isAfter(
                          periodStartDate[i].add(const Duration(days: -1))) &&
                      dateOnly.isBefore(periodEndDate[i])) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffFFBB7C))),
                        child: Text(
                          day.day.toString(),
                          style: calendarTextStyle,
                        ),
                      ),
                    );
                  }
                }

                for (var i = 0; i < ovulationDate.length; ++i) {
                  if (dateOnly.isAfter(fertilePeriodDateStart[i]) &&
                      dateOnly.isBefore(
                          ovulationDate[i].add(const Duration(days: 2)))) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffE3E3A7))),
                        child: Text(
                          day.day.toString(),
                          style: calendarTextStyle,
                        ),
                      ),
                    );
                  }
                }

                return Center(
                    child: Text(day.day.toString(), style: calendarTextStyle));
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

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
