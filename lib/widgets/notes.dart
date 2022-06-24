import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/widgets/note.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          AppLocalizations.of(context)!.noNotesError,
          style: const TextStyle(color: text),
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
                periodStart: notes[index].periodStart,
                intimacy: notes[index].intimacy);
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
