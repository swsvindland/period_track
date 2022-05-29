import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/widgets/calendar_header.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/constants.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    DateTime periodStartDate = DateTime.now().add(const Duration(days: -14));
    DateTime periodEndDate = periodStartDate.add(const Duration(days: 5));
    DateTime ovulationDate = periodStartDate.add(const Duration(days: 14));
    DateTime fertilePeriodDateStart =
        periodStartDate.add(const Duration(days: 9));
    // int menstrualCycleLength = 28;

    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Text(
            periodStartDate.year.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xffFFBB7C),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xffFFBB7C)),
          CalendarHeader(
            focusedDay: periodStartDate,
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
          TableCalendar(
            daysOfWeekVisible: false,
            headerVisible: false,
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2100, 01, 01),
            focusedDay: periodStartDate,
            rangeStartDay: periodStartDate,
            rangeEndDay: ovulationDate,
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                var text = DateFormat.MMMM().format(day);
                return Center(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 48, color: textColor),
                  ),
                );
              },
              todayBuilder: (context, day, day2) {
                return Center(
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(
                        color: textColor, backgroundColor: primaryDarkColor),
                  ),
                );
              },
              defaultBuilder: (context, day, day2) {
                return Center(
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(color: textColor),
                  ),
                );
              },
              disabledBuilder: (context, day, day2) {
                return const Center();
              },
              rangeHighlightBuilder: (context, day, isWithinRange) {
                if (!isWithinRange) {
                  return Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(color: textColor),
                    ),
                  );
                }

                if (day.isBefore(periodEndDate)) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffFFBB7C))),
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(color: textColor),
                      ),
                    ),
                  );
                } else if (day.isAfter(fertilePeriodDateStart) && day.isBefore(ovulationDate)) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffE3E3A7))),
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(color: textColor),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(color: textColor),
                    ),
                  );
                }
              },
              rangeStartBuilder: (context, day, day2) {
                return Center(
                  child: CircleAvatar(
                    backgroundColor: primaryDarkColor,
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(color: textColor),
                    ),
                  ),
                );
              },
              rangeEndBuilder: (context, day, day2) {
                return Center(
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff989859),
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(color: textColor),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
