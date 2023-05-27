import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateField extends StatelessWidget {
  DateField({Key? key, required this.controller, required this.onChanged}) : super(key: key);
  final TextEditingController controller;
  final Function(DateTime?)? onChanged;

  final format = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: controller,
        format: format,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.date,
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