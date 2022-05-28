import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text("This is title"),
        subtitle: Text("This is subtitle"),
      ),
    );
  }
}
