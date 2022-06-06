class Preferences {
  int defaultCycleLength;
  int start;

  Preferences({required this.defaultCycleLength, required this.start });

  void setDefaultCycleLength(int value) {
    defaultCycleLength = value;
  }

  void setStartTime(int value) {
    start = value;
  }

  static Preferences empty() {
    return Preferences(defaultCycleLength: 28, start: 7);
  }

  factory Preferences.fromMap(Map data) {
    data = data;
    return Preferences(
        defaultCycleLength: data['defaultCycleLength'],
        start: data['start'].toDate().hour);
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data;
    return {
      'defaultCycleLength': data.defaultCycleLength,
      'start': DateTime.parse(
          '2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
    };
  }
}
