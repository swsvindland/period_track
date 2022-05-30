import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/services/database_service.dart';
import 'package:provider/provider.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({Key? key}) : super(key: key);

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _periodStart = false;
  bool _intimacy = false;

  @override
  void dispose() {
    super.dispose();

    // Clean up the controllers when the widget is disposed.
    _titleController.dispose();
    _bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    submit() async {
      if (user == null) return;

      await _db.addNote(
          user.uid,
          NoteModel(
              uid: user.uid,
              date: DateUtils.dateOnly(_selectedDate),
              title: _titleController.text,
              body: _bodyController.text,
              periodStart: _periodStart,
              intimacy: _intimacy));
    }

    Widget cancelButton = TextButton(
      child: const Text('CANCEL'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: () {
        submit();
        Navigator.of(context).pop();
      },
      child: const Text('ADD'),
    );

    return AlertDialog(
      title: const Text("New Note"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 600,
          height: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDatePickerFormField(
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  fieldLabelText: 'Date',
                  initialDate: _selectedDate,
                  onDateSubmitted: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  minLines: 4,
                  maxLines: 6,
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                  ),
                ),
                CheckboxListTile(
                    title: const Text('Period Start'),
                    value: _periodStart,
                    onChanged: (val) {
                      setState(() {
                        _periodStart = val ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading),
                CheckboxListTile(
                    title: const Text('Intimacy'),
                    value: _intimacy,
                    onChanged: (val) {
                      setState(() {
                        _intimacy = val ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading),
              ],
            ),
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
