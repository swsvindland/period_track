import 'package:flutter/material.dart';
import 'package:period_track/utils/constants.dart';

class Note extends StatelessWidget {
  const Note({Key? key, required this.title, required this.body})
      : super(key: key);
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: ListTile(
          title: Text(title),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(body),
              const SizedBox(height: 8),
              Row(
                children: const [
                  CircleAvatar(backgroundColor: primaryDarkColor, maxRadius: 4),
                  SizedBox(width: 8),
                  CircleAvatar(
                      backgroundColor: Color(0xffECCDD6), maxRadius: 4),
                  SizedBox(width: 8),
                  CircleAvatar(
                      backgroundColor: Colors.red, maxRadius: 4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
