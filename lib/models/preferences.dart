class Preferences {
  int start;

  Preferences({required this.start });

  void setStartTime(int value) {
    start = value;
  }


  static Preferences empty() {
    return Preferences(start: 7);
  }

  factory Preferences.fromMap(Map data) {
    data = data;

    return Preferences(
        start: data['start'].toDate().hour);
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data;
    return {
      'start': DateTime.parse(
          '2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
    };
  }
}
