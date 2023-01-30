import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:period_track/models/note.dart';
import 'package:period_track/services/database_service.dart';
import 'package:period_track/utils/constants.dart';
import 'package:period_track/widgets/date_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/colors.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({Key? key, required this.date}) : super(key: key);
  final DateTime? date;

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // note
  late TextEditingController _dateController;
  late TextEditingController _noteController;
  late bool _periodStart;
  late bool _intimacy;
  FlowRate? _flow;

  // symptoms
  late bool _cramps;
  late bool _acne;
  late bool _tenderBreasts;
  late bool _headache;
  late bool _constipation;
  late bool _diarrhea;
  late bool _fatigue;
  late bool _nausea;
  late bool _cravings;
  late bool _bloating;
  late bool _backache;
  late bool _perineumPain;

  var _isNew = true;
  var _firstMount = true;

  @override
  void initState() {
    super.initState();
    var date = widget.date ?? DateUtils.dateOnly(DateTime.now());

    // note init
    _dateController = TextEditingController();
    _dateController.text = DateFormat.yMd().format(date);
    _noteController = TextEditingController();
    _periodStart = false;
    _intimacy = false;
    _flow = null;
    
    // symptom init
    _cramps = false;
    _acne = false;
    _tenderBreasts = false;
    _headache = false;
    _constipation = false;
    _diarrhea = false;
    _fatigue = false;
    _nausea = false;
    _cravings = false;
    _bloating = false;
    _backache = false;
    _perineumPain = false;
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
        ? notes.where((element) => DateUtils.dateOnly(element.date) == date)
        : null;

    if (_firstMount && note != null && note.isNotEmpty) {
      setState(() {
        _firstMount = false;
        _isNew = false;

        // note setup
        _noteController.text = note.first.note;
        _periodStart = note.first.periodStart;
        _intimacy = note.first.intimacy;
        _flow = note.first.flow;

        // symptom setup
        _cramps = note.first.cramps ?? false;
        _acne = note.first.acne ?? false;
        _tenderBreasts = note.first.tenderBreasts ?? false;
        _headache = note.first.headache ?? false;
        _constipation = note.first.constipation ?? false;
        _diarrhea = note.first.diarrhea ?? false;
        _fatigue = note.first.fatigue ?? false;
        _nausea = note.first.nausea ?? false;
        _cravings = note.first.cravings ?? false;
        _bloating = note.first.bloating ?? false;
        _backache = note.first.backache ?? false;
        _perineumPain = note.first.perineumPain ?? false;
      });
    }

    submit() async {
      if (user == null) return;
      DateFormat inputFormat = DateFormat.yMd();

      if (_isNew == false) {
        await _db.updateNote(
          user.uid,
          NoteModel(
            uid: user.uid,
            date: DateUtils.dateOnly(inputFormat.parse(_dateController.text)),
            note: _noteController.text,
            periodStart: _periodStart,
            intimacy: _intimacy,
            flow: _flow,
            cramps: _cramps,
            acne: _acne,
            tenderBreasts: _tenderBreasts,
            headache: _headache,
            constipation: _constipation,
            diarrhea: _diarrhea,
            fatigue: _fatigue,
            nausea: _nausea,
            cravings: _cravings,
            bloating: _bloating,
            backache: _backache,
            perineumPain: _perineumPain,
          ),
        );
      } else {
        await _db.addNote(
          user.uid,
          NoteModel(
            uid: user.uid,
            date: DateUtils.dateOnly(inputFormat.parse(_dateController.text)),
            note: _noteController.text,
            periodStart: _periodStart,
            intimacy: _intimacy,
            flow: _flow,
            cramps: _cramps,
            acne: _acne,
            tenderBreasts: _tenderBreasts,
            headache: _headache,
            constipation: _constipation,
            diarrhea: _diarrhea,
            fatigue: _fatigue,
            nausea: _nausea,
            cravings: _cravings,
            bloating: _bloating,
            backache: _backache,
            perineumPain: _perineumPain,
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 36),
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
                              Text(AppLocalizations.of(context)!.periodStart),
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
                              Text(AppLocalizations.of(context)!.intimacy),
                            ]),
                          ],
                        ),
                        const Text('Flow'),
                        ToggleButtons(
                          selectedBorderColor: primaryDark,
                          onPressed: (int index) {
                            setState(() {
                              switch (index) {
                                case 0:
                                  _flow = FlowRate.spotting;
                                  break;
                                case 1:
                                  _flow = FlowRate.light;
                                  break;
                                case 2:
                                  _flow = FlowRate.normal;
                                  break;
                                case 3:
                                  _flow = FlowRate.heavy;
                                  break;
                              }
                            });
                          },
                          isSelected: [
                            _flow == FlowRate.spotting,
                            _flow == FlowRate.light,
                            _flow == FlowRate.normal,
                            _flow == FlowRate.heavy
                          ],
                          children: [
                            Image.asset('images/flow-spotting.png', height: 24),
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
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.note,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.symptoms.toUpperCase(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Wrap(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _cramps,
                              onChanged: (val) {
                                setState(() {
                                  _cramps = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.cramps),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _acne,
                              onChanged: (val) {
                                setState(() {
                                  _acne = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.acne),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _tenderBreasts,
                              onChanged: (val) {
                                setState(() {
                                  _tenderBreasts = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.tenderBreasts),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _headache,
                              onChanged: (val) {
                                setState(() {
                                  _headache = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.headache),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _constipation,
                              onChanged: (val) {
                                setState(() {
                                  _constipation = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.constipation),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _diarrhea,
                              onChanged: (val) {
                                setState(() {
                                  _diarrhea = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.diarrhea),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _fatigue,
                              onChanged: (val) {
                                setState(() {
                                  _fatigue = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.fatigue),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _nausea,
                              onChanged: (val) {
                                setState(() {
                                  _nausea = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.nausea),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _cravings,
                              onChanged: (val) {
                                setState(() {
                                  _cravings = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.cravings),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _bloating,
                              onChanged: (val) {
                                setState(() {
                                  _bloating = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.bloating),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _backache,
                              onChanged: (val) {
                                setState(() {
                                  _backache = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.backache),
                          ]),
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(children: [
                            Checkbox(
                              value: _perineumPain,
                              onChanged: (val) {
                                setState(() {
                                  _perineumPain = val ?? false;
                                });
                              },
                            ),
                            Text(AppLocalizations.of(context)!.perineumPain),
                          ]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(24),
          //     child: SizedBox(
          //       width: 600,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(AppLocalizations.of(context)!.mood.toUpperCase(), style: const TextStyle(fontSize: 14),),
          //           Row(
          //             children: [
          //               Row(children: [
          //                 Checkbox(
          //                   value: _periodStart,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _periodStart = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.calm),
          //               ]),
          //               Row(children: [
          //                 Checkbox(
          //                   value: _intimacy,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _intimacy = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.happy),
          //               ]),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Row(children: [
          //                 Checkbox(
          //                   value: _periodStart,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _periodStart = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.energetic),
          //               ]),
          //               Row(children: [
          //                 Checkbox(
          //                   value: _intimacy,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _intimacy = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.frisky),
          //               ]),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Row(children: [
          //                 Checkbox(
          //                   value: _periodStart,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _periodStart = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.irritated),
          //               ]),
          //               Row(children: [
          //                 Checkbox(
          //                   value: _intimacy,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _intimacy = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.angry),
          //               ]),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Row(children: [
          //                 Checkbox(
          //                   value: _periodStart,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _periodStart = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.sad),
          //               ]),
          //               Row(children: [
          //                 Checkbox(
          //                   value: _intimacy,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _intimacy = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.anxious),
          //               ]),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Row(children: [
          //                 Checkbox(
          //                   value: _periodStart,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _periodStart = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.apathetic),
          //               ]),
          //               Row(children: [
          //                 Checkbox(
          //                   value: _intimacy,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _intimacy = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.confused),
          //               ]),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Row(children: [
          //                 Checkbox(
          //                   value: _periodStart,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _periodStart = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.guilty),
          //               ]),
          //               Row(children: [
          //                 Checkbox(
          //                   value: _intimacy,
          //                   onChanged: (val) {
          //                     setState(() {
          //                       _intimacy = val ?? false;
          //                     });
          //                   },
          //                 ),
          //                 Text(AppLocalizations.of(context)!.overwhelmed),
          //               ]),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                submit();
                navigatorKey.currentState!.pop();
              },
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(secondaryLight),
                backgroundColor: MaterialStateProperty.all<Color>(primaryDark),
              ),
              child: Text(
                AppLocalizations.of(context)!.submit,
                style: const TextStyle(
                  fontSize: 16.0,
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
                AppLocalizations.of(context)!.delete,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
