class SugarCenterEntity {
  final String? id;
  final String? name;
  final String? image;
  final String? district;
  final String? phoneNumber;

  SugarCenterEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.district,
      required this.phoneNumber});

  factory SugarCenterEntity.fromJson(Map<String, dynamic> json) {
    return SugarCenterEntity(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      district: json['district'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['district'] = district;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}