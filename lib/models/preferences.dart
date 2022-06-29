class Preferences {
  int defaultCycleLength;
  int start;
  bool adFree;
  bool disclaimer;

  Preferences({required this.defaultCycleLength, required this.start, required this.adFree, required this.disclaimer });

  void setDefaultCycleLength(int value) {
    defaultCycleLength = value;
  }

  void setStartTime(int value) {
    start = value;
  }

  void agreeToDisclaimer() {
    disclaimer = true;
  }

  static Preferences empty() {
    return Preferences(defaultCycleLength: 28, start: 7, adFree: false, disclaimer: true);
  }

  factory Preferences.fromMap(Map data) {
    data = data;
    return Preferences(
        defaultCycleLength: data['defaultCycleLength'],
        start: data['start'].toDate().hour,
        adFree: data['adFree'],
        disclaimer: data['disclaimer']
    );
  }

  static Map<String, dynamic> toMap(Preferences data) {
    data = data;
    return {
      'defaultCycleLength': data.defaultCycleLength,
      'start': DateTime.parse(
          '2000-01-01 ${data.start.toString().padLeft(2, '0')}:00:00'),
      'adFree': data.adFree,
      'disclaimer': data.disclaimer
    };
  }
}
