import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/widgets/note.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    return ListView.builder(
      itemBuilder: (buildContext, index){
        return Note(title: DateFormat.MMMMd(Localizations.localeOf(context).languageCode).format(notes[index].date) , body: notes[index].note);
      },
      itemCount: notes.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      scrollDirection: Axis.vertical,
    );
  }
}
