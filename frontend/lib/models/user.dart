import 'dart:convert';

class User {
  final int? id;
  final String name;

  String email;

  String? phoneNumber;

  final DateTime? birthDate;

  final DateTime? createdAt;

  String? password;

  DateTime? lastLoggedIn;

  User(this.email, this.name, 
      {this.password, this.birthDate, this.createdAt,
      this.phoneNumber, this.lastLoggedIn, this.id});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthDate =
            json['birthDate'] == null ? null : jsonDecode(json['birthDate']),
        createdAt = jsonDecode(json['createdAt']),
        lastLoggedIn = jsonDecode(json['lastLoggedIn']),
        phoneNumber = json['phoneNumber'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'birthDate': birthDate,
        'createdAt': createdAt,
        'lastLoggedIn': lastLoggedIn,
        'phoneNumber': phoneNumber,
      };
}
