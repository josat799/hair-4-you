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

  User(
    this.id,
    this.name,
    this.emails,
    this.birthDate,
    this.phoneNumber,
    this.userTypes,
    this.accountCreated,
    this.lastLoggedIn,
  );
}
