import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/utils/constants.dart';

class CalendarKey extends StatelessWidget {
  const CalendarKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CalendarKeyItem(
                  icon: CalendarKeyItemIconCircle(color: primaryDarkColor),
                  text: 'cycle begins'),
              CalendarKeyItem(
                  icon: CalendarKeyItemIconCircle(color: Color(0xff989859)),
                  text: 'est. ovulation'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CalendarKeyItem(
                  icon: CalendarKeyItemIconOutlinedCircle(
                      color: Color(0xffFFBB7C)),
                  text: 'period'),
              CalendarKeyItem(
                  icon: CalendarKeyItemIconOutlinedCircle(
                      color: Color(0xffE3E3A7)),
                  text: 'est. fertile days'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CalendarKeyItem(
                  icon: CalendarKeyItemIconOutlinedCircle(
                      color: Color(0xffECCDD6)),
                  text: 'est. cycle'),
              CalendarKeyItem(
                  icon: CalendarKeyItemIconDot(color: Color(0xffFFBB7C)),
                  text: 'notes'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(width: 150),
              CalendarKeyItem(
                  icon: CalendarKeyItemIconDot(color: Color(0xffECCDD6)),
                  text: 'intimacy'),
            ],
          ),
        )
      ],
    );
  }
}

class CalendarKeyItem extends StatelessWidget {
  const CalendarKeyItem({Key? key, required this.icon, required this.text})
      : super(key: key);
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            child: icon,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.josefinSans(
                color: const Color(0xffFFF3E8),
                fontSize: 12,
                letterSpacing: 0.12),
          )
        ],
      ),
    );
  }
}

class CalendarKeyItemIconCircle extends StatelessWidget {
  const CalendarKeyItemIconCircle({Key? key, required this.color})
      : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: color,
        child: const SizedBox(
          height: 16,
          width: 16,
        ));
  }
}

class CalendarKeyItemIconOutlinedCircle extends StatelessWidget {
  const CalendarKeyItemIconOutlinedCircle({Key? key, required this.color})
      : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: color)),
        child: const SizedBox(width: 16, height: 16));
  }
}

class CalendarKeyItemIconDot extends StatelessWidget {
  const CalendarKeyItemIconDot({Key? key, required this.color})
      : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(backgroundColor: color, maxRadius: 4);
  }
}
