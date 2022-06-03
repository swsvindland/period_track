import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:period_track/models/note.dart';
import 'package:provider/provider.dart';

import '../utils/helper.dart';


class CycleLength extends StatelessWidget {
  const CycleLength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();
    var cycles = computeMenstrualLengthsForGraph(notes.where((element) => element.periodStart).map((e) => e.date).toList());

    if (cycles.isEmpty) {
      return const SizedBox(
        height: 300,
        width: 600,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Text(
                'Looks like you have no weigh ins. Click the scale icon to get started.'),
          ),
        ),
      );
    }

    return TimeSeriesChart(
      _createSampleData(cycles, context),
      animate: true,
      primaryMeasureAxis: const NumericAxisSpec(
        tickProviderSpec: BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }

  static List<Series<Cycle, DateTime>> _createSampleData(List<Cycle> cycles, BuildContext context) {
    final List<Cycle> data = [];
    for (var cycle in cycles) {
      data.add(Cycle(date: cycle.date, length: cycle.length));
    }

    data.sort((a, b) {
      return a.date.compareTo(b.date);
    });

    final regression = [
      Cycle(date: data.first.date, length: data.first.length),
      Cycle(date: data.last.date, length: data.last.length)
    ];

    return [
      Series<Cycle, DateTime>(
        id: 'WeighIns',
        colorFn: (_, __) => MaterialPalette.purple.shadeDefault,
        domainFn: (Cycle sales, _) => sales.date,
        measureFn: (Cycle sales, _) => sales.length,
        data: data,
      ),
      Series<Cycle, DateTime>(
        id: 'Average',
        colorFn: (_, __) => MaterialPalette.pink.shadeDefault,
        domainFn: (Cycle sales, _) => sales.date,
        measureFn: (Cycle sales, _) => sales.length,
        data: regression,
      ),
    ];
  }
}