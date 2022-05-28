import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:period_track/services/database_service.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notes = ['a', 'b', 'c', 'd'];

    return ListView.builder(
      itemBuilder: (BuildContext, index){
        return const Card(
          child: ListTile(
            title: Text("This is title"),
            subtitle: Text("This is subtitle"),
          ),
        );
      },
      itemCount: notes.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      scrollDirection: Axis.vertical,
    );
  }
}
