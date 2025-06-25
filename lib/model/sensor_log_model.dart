class SensorLogModel {
  final String id;
  final double ph;
  final double wtemp;
  final double rtemp;
  final int hum;
  final int tds;
  final int timestamp;

  SensorLogModel({
    required this.id,
    required this.ph,
    required this.wtemp,
    required this.rtemp,
    required this.hum,
    required this.tds,
    required this.timestamp,
  });

  factory SensorLogModel.fromJson(String id, Map<String, dynamic> map) {
    return SensorLogModel(
      id: id,
      ph: (map['ph'] ?? 0).toDouble(),
      wtemp: (map['wtemp'] ?? 0).toDouble(),
      rtemp: (map['rtemp'] ?? 0).toDouble(),
      hum: (map['hum'] ?? 0).toInt(),
      tds: (map['tds'] ?? 0).toInt(),
      timestamp: (map['timestamp'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ph': ph,
      'wtemp': wtemp,
      'rtemp': rtemp,
      'hum': hum,
      'tds': tds,
      'timestamp': timestamp,
    };
  }
}
