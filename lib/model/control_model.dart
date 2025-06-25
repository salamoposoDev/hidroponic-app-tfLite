class ControlModel {
  final int phDown;
  final int nutrisi;
  final int phUp;
  final int air;

  ControlModel({
    required this.phDown,
    required this.nutrisi,
    required this.phUp,
    required this.air,
  });

  factory ControlModel.fromJson(Map<String, dynamic> json) {
    return ControlModel(
      phDown: json['phDown'] ?? 0,
      nutrisi: json['nutrisi'] ?? 0,
      phUp: json['phUp'] ?? 0,
      air: json['air'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'phDown': phDown, 'nutrisi': nutrisi, 'phUp': phUp, 'air': air};
  }
}
