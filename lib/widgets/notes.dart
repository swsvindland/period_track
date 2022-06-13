import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/widgets/note.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();
    notes.sort((a, b) {
      return b.date.compareTo(a.date);
    });

    if (notes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'Looks like you have not recorded a period yet. Add a new note to get started.',
          style: TextStyle(color: text),
        ),
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 600,
        child: ListView.builder(
          itemBuilder: (buildContext, index) {
            return Note(
              title: notes[index].date,
              body: notes[index].note,
              flow: notes[index].flow,
            );
          },
          itemCount: notes.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(4),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
