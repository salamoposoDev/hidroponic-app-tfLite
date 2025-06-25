class PumpHistoryModel {
  final String id; // Firebase push key (seperti -Nx123abc456)
  final double hum;
  final String phDown;
  final String tds;
  final String phUp;
  final String air;
  final double ph;
  final double wtemp;
  final double rtemp;
  final String mode;
  final int timestamp;

  PumpHistoryModel({
    required this.id,
    required this.hum,
    required this.phDown,
    required this.tds,
    required this.phUp,
    required this.air,
    required this.ph,
    required this.wtemp,
    required this.rtemp,
    required this.mode,
    required this.timestamp,
  });

  factory PumpHistoryModel.fromJson(String id, Map<String, dynamic> json) {
    return PumpHistoryModel(
      id: id,
      hum: (json['hum'] as num).toDouble(),
      phDown: json['phDown'] as String,
      tds: json['tds'] as String,
      phUp: json['phUp'] as String,
      air: json['air'] as String,
      ph: (json['ph'] as num).toDouble(),
      wtemp: (json['wtemp'] as num).toDouble(),
      rtemp: (json['rtemp'] as num).toDouble(),
      mode: json['mode'] as String,
      timestamp: json['timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hum': hum,
      'phDown': phDown,
      'tds': tds,
      'phUp': phUp,
      'air': air,
      'ph': ph,
      'wtemp': wtemp,
      'rtemp': rtemp,
      'mode': mode,
      'timestamp': timestamp,
    };
  }
}
