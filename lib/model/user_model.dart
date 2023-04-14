// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String uid;
  final String token;

  UserModel({required this.email, required this.name, required this.uid, required this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email']  ?? '',
      name: map['name']  ?? '',
      uid: map['_id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? email,
    String? name,
    String? uid,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
