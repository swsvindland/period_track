import 'package:flutter/material.dart';
import 'package:period_track/widgets/note.dart';
import 'package:period_track/widgets/note_ad.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();

    return ListView.builder(
      itemBuilder: (buildContext, index){
        return index % 5 == 0 && index != 0 ? const NoteAd() : Note(title: notes[index].title, body: notes[index].body,);
      },
      itemCount: notes.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      scrollDirection: Axis.vertical,
    );
  }
}
