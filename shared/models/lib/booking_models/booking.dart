import 'package:models/user_models/user.dart';

class Booking {
  final String id;
  final DateTime createdAt;
  String title;
  String description;
  DateTime lastEdited;
  DateTime startTime;
  Duration duration;

    required this.duration,
    this.description,
    this.createdAt,
    this.endTime,
    this.lastEdited,
    this.amountOfCustomers, {
    List<User> hairDressers = const [],
    List<User> customers = const [],
  }) {
  Set<String> getDuration() {
    return <String>{startTime.toString(), startTime.add(duration).toString()};
  }
        duration = json['duration'],
      'duration': duration,
  }
}
