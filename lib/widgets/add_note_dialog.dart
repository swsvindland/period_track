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
  late DateTime _selectedDate;
  late TextEditingController _noteController;
  late bool _periodStart;
  late bool _intimacy;
  FlowRate? _flow;

  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.now();
    _noteController = TextEditingController();
    _periodStart = false;
    _intimacy = false;
    _flow = null;
  }

  @override
  void dispose() {
    super.dispose();

    // Clean up the controllers when the widget is disposed.
    _noteController.dispose();
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
          note: _noteController.text,
          periodStart: _periodStart,
          intimacy: _intimacy,
          flow: _flow
        ),
      );
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
      content: SizedBox(
        width: 600,
        height: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                  minLines: 4,
                  maxLines: 6,
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                  ),
                ),
                Row(children: [
                  Checkbox(
                    value: _periodStart,
                    onChanged: (val) {
                      setState(() {
                        _periodStart = val ?? false;
                      });
                    },
                  ),
                  const Text("Period Start"),
                ]),
                Row(children: [
                  Checkbox(
                    value: _intimacy,
                    onChanged: (val) {
                      setState(() {
                        _intimacy = val ?? false;
                      });
                    },
                  ),
                  const Text("Intimacy"),
                ]),
                Text('Flow', style: Theme.of(context).textTheme.headlineSmall),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 4,
                  visualDensity: VisualDensity.compact,
                  title: const Text('Light'),
                  leading: Radio<FlowRate>(
                    value: FlowRate.light,
                    groupValue: _flow,
                    onChanged: (FlowRate? value) {
                      setState(() {
                        _flow = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 4,
                  visualDensity: VisualDensity.compact,
                  title: const Text('Normal'),
                  leading: Radio<FlowRate>(
                    value: FlowRate.normal,
                    groupValue: _flow,
                    onChanged: (FlowRate? value) {
                      setState(() {
                        _flow = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 4,
                  visualDensity: VisualDensity.compact,
                  title: const Text('Heavy'),
                  leading: Radio<FlowRate>(
                    value: FlowRate.heavy,
                    groupValue: _flow,
                    onChanged: (FlowRate? value) {
                      setState(() {
                        _flow = value;
                      });
                    },
                  ),
                ),
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