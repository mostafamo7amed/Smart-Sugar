class SugarCenterModel {
  final String? id;
  final String? name;
  final String? image;
  final String? longitude;
  final String? latitude;
  final String? phoneNumber;

  SugarCenterModel(
      {required this.id,
        required this.name,
        required this.image,
        required this.latitude,
        required this.longitude,
        required this.phoneNumber});

  factory SugarCenterModel.fromJson(Map<String, dynamic> json) {
    return SugarCenterModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
