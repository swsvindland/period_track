import 'package:flutter/material.dart';
import 'package:period_track/widgets/note.dart';
import 'package:period_track/widgets/note_ad.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];

    return ListView.builder(
      itemBuilder: (buildContext, index){
        return index % 5 == 0 && index != 0 ? const NoteAd() : const Note();
      },
      itemCount: notes.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      scrollDirection: Axis.vertical,
    );
  }
}
