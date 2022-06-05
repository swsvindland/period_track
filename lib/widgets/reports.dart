import 'package:flutter/material.dart';
import 'package:period_track/utils/constants.dart';

import 'cycle_length.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Center(
            child: SizedBox(
              height: 350,
              width: 600,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: ListTile(
                      title: Text(
                        'Period Length',
                      ),
                      subtitle: SizedBox(height: 275, child: CycleLength()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
