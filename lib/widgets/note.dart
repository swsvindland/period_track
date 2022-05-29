import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note({Key? key, required this.title, required this.body}) : super(key: key);
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(body),
      ),
    );
  }
}
