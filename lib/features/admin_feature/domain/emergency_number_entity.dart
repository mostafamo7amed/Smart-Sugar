class EmergencyNumberEntity {
  final String id;
  final String number;
  final String name;

  EmergencyNumberEntity({
    required this.id,
    required this.number,
    required this.name,
  });

  factory EmergencyNumberEntity.fromJson(Map<String, dynamic> json) {
    return EmergencyNumberEntity(
      id: json['id'],
      number: json['number'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['name'] = name;
    return data;
  }
}