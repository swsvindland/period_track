import 'package:flutter/material.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/add_note_form.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note', style: TextStyle(color: textColor)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AddNoteForm(
          date: DateTime.parse(
            arguments["id"].toString(),
          ),
        ),
      ),
    );
  }
}
