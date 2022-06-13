import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/add_note_form.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../services/database_service.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({Key? key}) : super(key: key);
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const Scaffold(
        body: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry', style: TextStyle(color: text)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: text,
          ),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      body: MultiProvider(
        providers: [
          StreamProvider<Iterable<NoteModel>>.value(
            initialData: const [],
            value: db.streamNotes(user.uid),
            catchError: (_, err) => [],
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AddNoteForm(
            date: DateTime.parse(
              arguments["id"].toString(),
            ),
          ),
        ),
      ),
    );
  }
}
