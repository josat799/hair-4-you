enum Role {
  customer,
  hairdresser,
  owner,
  admin,
}

class User {
  int? id;

  String? name;

  String? email;

  String? phoneNumber;

  DateTime? birthDate;

  DateTime? createdAt;

  String? password;

  DateTime? lastLoggedIn;

  Role? role;

  User({
    required this.email,
    this.name,
    this.password,
    this.birthDate,
    this.createdAt,
    this.phoneNumber,
    this.lastLoggedIn,
    this.id,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthDate = json['birthDate'] == null
            ? null
            : DateTime.parse(json['birthDate']),
        createdAt = json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        lastLoggedIn = json['lastLoggedIn'] == null
            ? null
            : DateTime.parse(json['lastLoggedIn']),
        phoneNumber = json['phoneNumber'],
        id = json['id'],
        role = json['role'] == null
            ? null
            : Role.values.firstWhere(
                (element) => element.toString() == 'Role.' + json['role']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'birthDate': birthDate,
        'createdAt': createdAt,
        'lastLoggedIn': lastLoggedIn,
        'phoneNumber': phoneNumber,
        'password': password,
        'role': role,
      };

  bool identical(User user) {
    return user.id == this.id;
  }
}
