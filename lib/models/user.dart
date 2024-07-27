import 'dart:convert';

class User {
  final String id;
  final String name;
  final String address;
  final String email;
  final String password;
  final String type;
  final String token;
  User( {
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.password,
    required this.type,
    required this.token,
  });

   factory User.fromMap(Map<String, dynamic> map) {
    return User(
      address:map['address'] ??'',
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
    };
  }

 

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));


}
