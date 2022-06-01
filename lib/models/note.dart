enum FlowRate { light, normal, heavy }

class NoteModel {
  String uid;
  DateTime date;
  String note;
  bool periodStart;
  bool intimacy;
  FlowRate? flow;

  NoteModel({required this.uid, required this.date, required this.note, required this.periodStart, required this.intimacy, this.flow});

  factory NoteModel.fromMap(Map data) {
    data = data;

    return NoteModel(
      uid: data['uid'],
      date: data['date'].toDate(),
      note: data['note'],
      periodStart: data['periodStart'],
      intimacy: data['intimacy'],
      flow: data['flow'] == "0" ? FlowRate.light : data['flow'] == "1" ? FlowRate.normal : FlowRate.heavy
    );
  }

  static Map<String, dynamic> toMap(NoteModel data) {
    data = data;
    return {
      'uid': data.uid,
      'date': data.date,
      'note': data.note,
      'periodStart': data.periodStart,
      'intimacy': data.intimacy,
      'flow': data.flow.toString()
    };
  }
}
