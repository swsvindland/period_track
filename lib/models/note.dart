class NoteModel {
  String uid;
  DateTime date;
  String title;
  String body;
  bool periodStart;
  bool intimacy;

  NoteModel({required this.uid, required this.date, required this.title, required this.body, required this.periodStart, required this.intimacy});

  factory NoteModel.fromMap(Map data) {
    data = data;

    return NoteModel(
      uid: data['uid'],
      date: data['date'].toDate(),
      title: data['title'],
      body: data['body'],
      periodStart: data['periodStart'],
      intimacy: data['intimacy']
    );
  }

  static Map<String, dynamic> toMap(NoteModel data) {
    data = data;
    return {
      'uid': data.uid,
      'date': data.date,
      'title': data.title,
      'body': data.body,
      'periodStart': data.periodStart,
      'intimacy': data.intimacy
    };
  }
}
