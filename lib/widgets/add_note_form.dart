import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/utils/constants.dart';
import 'package:provider/provider.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({Key? key}) : super(key: key);

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
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

      print(_selectedDate.toIso8601String());

      await _db.addNote(
        user.uid,
        NoteModel(
            uid: user.uid,
            date: DateUtils.dateOnly(_selectedDate),
            note: _noteController.text,
            periodStart: _periodStart,
            intimacy: _intimacy,
            flow: _flow),
      );
    }

    return Card(
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
                  InputDatePickerFormField(
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    fieldLabelText: 'Date',
                    initialDate: _selectedDate,
                    onDateSaved: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
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
                  Text('Flow',
                      style: Theme.of(context).textTheme.headlineSmall),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
