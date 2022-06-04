import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/models/note.dart';
import 'package:provider/provider.dart';

import '../utils/helper.dart';


class CycleLength extends StatelessWidget {
  const CycleLength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    if (notes.isEmpty) {
      return const SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Text(
                'Looks like you have not recorded a period yet. Add a new note to get started.'),
          ),
        ),
      );
    }

    var cycles = computeMenstrualLengthsForGraph(notes.where((element) => element.periodStart).map((e) => e.date).toList());

    return BarChart(
      _createSampleData(cycles, context),
      animate: true,
      primaryMeasureAxis: const NumericAxisSpec(
        tickProviderSpec: BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }

  static List<Series<Cycle, String>> _createSampleData(List<Cycle> cycles, BuildContext context) {
    final List<Cycle> data = [];
    for (var cycle in cycles) {
      data.add(Cycle(date: cycle.date, length: cycle.length));
    }

    data.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    return [
      Series<Cycle, String>(
        id: 'WeighIns',
        colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
        domainFn: (Cycle sales, _) => DateFormat.MMM(Localizations.localeOf(context).languageCode).format(sales.date),
        measureFn: (Cycle sales, _) => sales.length,
        data: data,
      ),
    ];
  }
}