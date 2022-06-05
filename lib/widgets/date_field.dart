import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  DateField({Key? key, required this.controller, required this.onChanged}) : super(key: key);
  final TextEditingController controller;
  final Function(DateTime?)? onChanged;

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: controller,
        format: format,
        decoration: const InputDecoration(
          labelText: 'Date',
        ),
        onShowPicker: (context, currentValue) async {
          return showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        onChanged: onChanged,
      ),
    ]);
  }
}