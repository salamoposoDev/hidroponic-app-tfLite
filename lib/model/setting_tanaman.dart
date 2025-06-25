class SettingTanamanModel {
  final String plantStr;
  final int day;
  final int ageInWeek;
  final int plantInt;
  final String tanggalTanam;
  SettingTanamanModel({
    required this.plantStr,
    required this.day,
    required this.ageInWeek,
    required this.plantInt,
    required this.tanggalTanam,
  });

  factory SettingTanamanModel.fromJson(Map<String, dynamic> json) {
    return SettingTanamanModel(
      plantStr: json['plantStr'] ?? '',
      day: json['day'] ?? 0,
      ageInWeek: json['ageInWeek'] ?? 0,
      plantInt: json['plantInt'] ?? 0,
      tanggalTanam: json['tanggalTanam'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plantStr': plantStr,
      'day': day,
      'ageInWeek': ageInWeek,
      'plantInt': plantInt,
      'tanggalTanam': tanggalTanam,
    };
  }
}
