class SensorsModel {
  final int hum;
  final int tds;
  final double ph;
  final double wtemp;
  final double rtemp;
  final int timestamp;

  SensorsModel({
    required this.hum,
    required this.tds,
    required this.ph,
    required this.wtemp,
    required this.rtemp,
    required this.timestamp,
  });

  factory SensorsModel.fromJson(Map<String, dynamic> json) {
    return SensorsModel(
      hum: json['hum'] as int,
      tds: json['tds'] as int,
      ph: (json['ph'] as num).toDouble(),
      wtemp: (json['wtemp'] as num).toDouble(),
      rtemp: (json['rtemp'] as num).toDouble(),
      timestamp: json['timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hum': hum,
      'tds': tds,
      'ph': ph,
      'wtemp': wtemp,
      'rtemp': rtemp,
      'timestamp': timestamp,
    };
  }
}
