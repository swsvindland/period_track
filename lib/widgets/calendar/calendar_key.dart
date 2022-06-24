import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_track/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            children: [
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconCircle(color: primaryDark),
                  text: AppLocalizations.of(context)!.cycleBegin.toLowerCase()),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconCircle(color: ternary),
                  text: AppLocalizations.of(context)!.estOvulation.toLowerCase()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconOutlinedCircle(
                      color: secondary),
                  text: AppLocalizations.of(context)!.period.toLowerCase()),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconOutlinedCircle(
                      color: ternaryLight),
                  text: AppLocalizations.of(context)!.estFertileDays.toLowerCase()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconOutlinedCircle(
                      color: primaryLight),
                  text: AppLocalizations.of(context)!.estCycle.toLowerCase()),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconDot(color: secondary),
                  text: AppLocalizations.of(context)!.notes.toLowerCase()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 150),
              CalendarKeyItem(
                  icon: const CalendarKeyItemIconDot(color: primaryLight),
                  text: AppLocalizations.of(context)!.intimacy.toLowerCase()),
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
                color: Theme.of(context).brightness == Brightness.light ? primaryDark : primaryLight,
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
