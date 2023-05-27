import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/models/preferences.dart';
import 'package:period_track/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/helper.dart';

class CycleLength extends StatelessWidget {
  const CycleLength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    if (notes.isEmpty) {
      return SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.noNotesError,
            ),
          ),
        ),
      );
    }

    var periodStarts = notes.where((element) => element.periodStart)
        .map((e) => e.date)
        .toList();

    var cycleLength = computeMenstrualLength(preferences.defaultCycleLength, periodStarts);
    var cycles = computeMenstrualLengthsForGraph(cycleLength, periodStarts);

    return charts.BarChart(
      _createSampleData(cycles, context),
      animate: true,
    );
  }

  static List<charts.Series<Cycle, String>> _createSampleData(
      List<Cycle> cycles, BuildContext context) {
    final List<Cycle> data = [];
    for (var cycle in cycles) {
      data.add(Cycle(date: cycle.date, length: cycle.length));
    }

    data.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    return [
      charts.Series<Cycle, String>(
        id: 'CycleLength',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(secondaryDark),
        domainFn: (Cycle sales, _) =>
            DateFormat.MMM(Localizations.localeOf(context).languageCode)
                .format(sales.date),
        measureFn: (Cycle sales, _) => sales.length,
        data: data,
      ),
    ];
  }
}
