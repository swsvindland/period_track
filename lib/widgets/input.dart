import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {Key? key,
        required this.label,
        this.validator,
        this.controller,
        this.decimal,
        this.variant,
        this.minLines,
        this.maxLines
      })
      : super(key: key);
  final String label;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool? decimal;
  final String? variant;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: controller,
        // The validator receives the text that the user has entered.
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        style: TextStyle(color: color),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: BorderSide(color: color),
            ),
            focusedBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: BorderSide(color: color),
            ),
            border: const OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(color: color)),
        keyboardType: TextInputType.numberWithOptions(
            decimal: decimal ?? true),
      ),
    );
  }
}