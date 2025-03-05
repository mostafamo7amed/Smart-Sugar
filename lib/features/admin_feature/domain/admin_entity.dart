class AdminEntity {
  final String uid;
  final String name;
  final String email;

  AdminEntity({required this.uid, required this.name, required this.email});

  factory AdminEntity.fromMap(Map<String, dynamic> map) {
    return AdminEntity(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
    );
  }
  toMap() => {'uid': uid, 'name': name, 'email': email};
}
