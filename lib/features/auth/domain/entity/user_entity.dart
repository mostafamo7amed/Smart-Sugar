class UserEntity {
  final String? uid;
  final String? name;
  final String? gender;
  final String? email;
  final String? weight;
  final String? height;
  final String? image;
  final String? dateOfBirth;
  final String? diabetesType;
  final String? therapyType;
  final String? insulinValue;
  final String? glucoseLowValue;
  final String? glucoseHighValue;
  final bool? fcmToken;

  UserEntity({
    this.uid,
    this.name,
    this.gender,
    this.email,
    this.weight,
    this.height,
    this.image,
    this.dateOfBirth,
    this.diabetesType,
    this.therapyType,
    this.insulinValue,
    this.glucoseLowValue,
    this.glucoseHighValue,
    this.fcmToken,
  });

  toMap() => {
        'uid': uid,
        'name': name,
        'gender': gender,
        'email': email,
        'weight': weight,
        'image': image,
        'dateOfBirth': dateOfBirth,
        'height': height,
        'diabetesType': diabetesType,
        'therapyType': therapyType,
        'insulinValue': insulinValue,
        'glucoseLowValue': glucoseLowValue,
        'glucoseHighValue': glucoseHighValue,
        'fcmToken': fcmToken
      };

  factory UserEntity.fromMap(Map<String, dynamic> map) => UserEntity(
        uid: map['uid'],
        name: map['name'],
        gender: map['gender'],
        email: map['email'],
        weight: map['weight'],
        height: map['height'],
        image: map['image'],
        dateOfBirth: map['dateOfBirth'],
        diabetesType: map['diabetesType'],
        therapyType: map['therapyType'],
        insulinValue: map['insulinValue'],
        glucoseLowValue: map['glucoseLowValue'],
        glucoseHighValue: map['glucoseHighValue'],
        fcmToken: map['fcmToken'],
      );
}
