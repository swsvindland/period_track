import 'package:flutter/material.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({Key? key}) : super(key: key);

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text('CANCEL'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: () {},
      child: const Text('ADD'),
    );

    return AlertDialog(
      title: const Text("New Note"),
      content: SizedBox(
        width: 600,
        height: 400,
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            CheckboxListTile(
                title: const Text('Period Start'),
                value: false,
                onChanged: (val) {},
                controlAffinity: ListTileControlAffinity.leading),
            CheckboxListTile(
                title: const Text('Intimacy'),
                value: false,
                onChanged: (val) {},
                controlAffinity: ListTileControlAffinity.leading),
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
