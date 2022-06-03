import 'package:flutter/material.dart';

import 'cycle_length.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(
            height: 300,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: CycleLength(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
