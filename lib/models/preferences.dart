class Preferences {
  int start;
  int end;

  Preferences({required this.start, required this.end});

  void setStartTime(int value) {
    start = value;
  }

  void setEndTime(int value) {
    end = value;
  }

  static Preferences empty() {
    return Preferences(start: 7, end: 20);
  }

  factory Preferences.fromMap(Map data) {
    data = data;

    return Preferences(
        start: data['start'].toDate().hour, end: data['end'].toDate().hour);
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data;
    return {
      'start': DateTime.parse(
          '2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
      'end': DateTime.parse(
          '2000-01-01 ${data.end.toString().padLeft(2, '0')}:00:00'),
    };
  }
}
