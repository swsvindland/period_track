import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/utils/constants.dart';

class Note extends StatelessWidget {
  const Note(
      {Key? key,
      required this.title,
      required this.body,
      required this.flow,
      required this.periodStart,
      required this.intimacy})
      : super(key: key);
  final DateTime title;
  final String body;
  final FlowRate? flow;
  final bool periodStart;
  final bool intimacy;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: ListTile(
          onTap: () {
            navigatorKey.currentState!.pushNamed('/add-note',
                arguments: {"id": DateUtils.dateOnly(title).toIso8601String()});
          },
          title: Text(
              DateFormat.MMMMd(Localizations.localeOf(context).languageCode)
                  .format(title)),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(body),
              const SizedBox(height: 8),
              Row(
                children: [
                  periodStart
                      ? const CircleAvatar(
                          backgroundColor: primaryDark, maxRadius: 4)
                      : const SizedBox(width: 0),
                  SizedBox(width: periodStart ? 8 : 0),
                  intimacy
                      ? const CircleAvatar(
                          backgroundColor: primaryLight, maxRadius: 4)
                      : const SizedBox(width: 0),
                  SizedBox(width: intimacy ? 8 : 0),
                  FlowIndicator(flow: flow)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FlowIndicator extends StatelessWidget {
  const FlowIndicator({Key? key, required this.flow}) : super(key: key);
  final FlowRate? flow;

  @override
  Widget build(BuildContext context) {
    if (flow == null) {
      return const SizedBox();
    }

    if (flow == FlowRate.spotting) {
      return Image.asset('images/flow-spotting.png', height: 24);
    }

    if (flow == FlowRate.light) {
      return Image.asset('images/flow-light.png', height: 24);
    }

    if (flow == FlowRate.normal) {
      return Image.asset('images/flow-normal.png', height: 24);
    }

    if (flow == FlowRate.heavy) {
      return Image.asset('images/flow-heavy.png', height: 24);
    }

    return const SizedBox();
  }
}
