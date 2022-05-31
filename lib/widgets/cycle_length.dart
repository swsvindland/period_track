import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';


class CycleLength extends StatelessWidget {
  const CycleLength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cycles = [28, 27, 29, 30, 26];

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

  static List<Series<TimeSeriesWeight, DateTime>> _createSampleData(
      List<int> cycles, BuildContext context) {
    int index = 0;
    final List<TimeSeriesWeight> data = [];
    for (var cycle in cycles) {
      data.add(TimeSeriesWeight(DateTime.now().add(Duration(days: index * 30)), cycle));
      index--;
    }

    data.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    final regression = [
      TimeSeriesWeight(data.first.time, data.first.length),
      TimeSeriesWeight(data.last.time, data.last.length)
    ];

    return [
      Series<TimeSeriesWeight, DateTime>(
        id: 'WeighIns',
        colorFn: (_, __) => MaterialPalette.pink.makeShades(10)[7],
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.length,
        data: data,
      ),
      Series<TimeSeriesWeight, DateTime>(
        id: 'Average',
        colorFn: (_, __) => MaterialPalette.pink.shadeDefault,
        domainFn: (TimeSeriesWeight sales, _) => sales.time,
        measureFn: (TimeSeriesWeight sales, _) => sales.length,
        data: regression,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeriesWeight {
  final DateTime time;
  final int length;

  TimeSeriesWeight(this.time, this.length);
}