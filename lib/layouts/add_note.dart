import 'package:flutter/material.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/add_note_form.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note',
            style: TextStyle(color: textColor)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor,),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: const Padding(padding: EdgeInsets.all(8), child: AddNoteForm()),
    );
  }
}
