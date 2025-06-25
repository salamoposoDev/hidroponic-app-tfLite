class JadwalModel {
  final String a;
  final String b;
  final String c;
  final String d;

  JadwalModel({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) {
    return JadwalModel(
      a: json['a'] ?? '00:00',
      b: json['b'] ?? '00:00',
      c: json['c'] ?? '00:00',
      d: json['d'] ?? '00:00',
    );
  }

  Map<String, dynamic> toJson() {
    return {'a': a, 'b': b, 'c': c, 'd': d};
  }
}
