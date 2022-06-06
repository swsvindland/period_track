import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/date_field.dart';
import 'package:provider/provider.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({Key? key, required this.date}) : super(key: key);
  final DateTime? date;

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;
  late TextEditingController _noteController;
  late bool _periodStart;
  late bool _intimacy;
  FlowRate? _flow;

  @override
  void initState() {
    super.initState();
    var date = widget.date ?? DateUtils.dateOnly(DateTime.now());

    _dateController = TextEditingController();
    _dateController.text = DateFormat.yMd().format(date);
    _noteController = TextEditingController();
    _periodStart = false;
    _intimacy = false;
    _flow = null;
  }

  @override
  void dispose() {
    super.dispose();

    // Clean up the controllers when the widget is disposed.
    _dateController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var date = widget.date ?? DateUtils.dateOnly(DateTime.now());
    var notes = Provider.of<Iterable<NoteModel>>(context).toList();
    var note = notes.isNotEmpty
        ? notes.where((element) => element.date == date)
        : null;

    if (note != null && note.isNotEmpty) {
      _noteController.text = note.first.note;
      _periodStart = note.first.periodStart;
      _intimacy = note.first.intimacy;
      _flow = note.first.flow;
    }

    submit() async {
      if (user == null) return;

      DateFormat inputFormat = DateFormat.yMd();
      await _db.addNote(
        user.uid,
        NoteModel(
          uid: user.uid,
          date: DateUtils.dateOnly(inputFormat.parse(_dateController.text)),
          note: _noteController.text,
          periodStart: _periodStart,
          intimacy: _intimacy,
          flow: _flow,
        ),
      );
    }

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 600,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DateField(
                        controller: _dateController,
                        onChanged: (day) {
                          var newNote = notes.isNotEmpty
                              ? notes.where((element) => element.date == day)
                              : null;

                          setState(() {
                            if (newNote != null && newNote.isNotEmpty) {
                              _noteController.text = newNote.first.note;
                              _periodStart = newNote.first.periodStart;
                              _intimacy = newNote.first.intimacy;
                              _flow = newNote.first.flow;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
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
                        ],
                      ),
                      const Text('Flow'),
                      ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            switch (index) {
                              case 0:
                                _flow = FlowRate.light;
                                break;
                              case 1:
                                _flow = FlowRate.normal;
                                break;
                              case 2:
                                _flow = FlowRate.heavy;
                                break;
                            }
                          });
                        },
                        isSelected: [
                          _flow == FlowRate.light,
                          _flow == FlowRate.normal,
                          _flow == FlowRate.heavy
                        ],
                        children: [
                          Image.asset('images/flow-light.png', height: 24),
                          Image.asset('images/flow-normal.png', height: 24),
                          Image.asset('images/flow-heavy.png', height: 24),
                        ],
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () {
              submit();
              navigatorKey.currentState!.pop();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(primaryDarkColor),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16.0,
                color: textColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await _db.deleteNote(user!.uid, date);
              navigatorKey.currentState!.pop();
            },
            child: Text(
              'Delete Note',
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
