class UserEntity {
  final String? uid;
  final String? name;
  final String? gender;
  final String? email;
  final String? weight;
  final String? image;
  final String? age;
  final String? diabetesType;
  final String? therapyType;
  final String? insulinValue;
  final String? glucoseLowValue;
  final String? glucoseHighValue;
  final String? fcmToken;

  UserEntity({
    this.uid,
    this.name,
    this.gender,
    this.email,
    this.weight,
    this.image,
    this.age,
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
        'age': age,
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
        image: map['image'],
        age: map['age'],
        diabetesType: map['diabetesType'],
        therapyType: map['therapyType'],
        insulinValue: map['insulinValue'],
        glucoseLowValue: map['glucoseLowValue'],
        glucoseHighValue: map['glucoseHighValue'],
        fcmToken: map['fcmToken'],
      );
}
