enum userType {
  customer,
  hairdresser,
  admin,
  owner,
}

class User {
  String id;
  String name;
  String phoneNumber;
  DateTime birthDate;
  DateTime accountCreated;
  DateTime lastLoggedIn;
  List<String> emails;
  List<userType> userTypes;

  User({
    required this.id,
    required this.name,
    required this.emails,
    required this.birthDate,
    required this.phoneNumber,
    required this.userTypes,
    required this.accountCreated,
    required this.lastLoggedIn,
  });
}
