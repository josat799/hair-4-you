import 'package:models/user_models/user.dart';

class Booking {
  final String id;
  final DateTime createdAt;
  String title;
  String? description;
  DateTime? lastEdited;
  DateTime startTime;
  Duration duration;
  List<User>? hairDressers = [];
  List<User>? customers = [];
  int? amountOfCustomers;

  Booking({
    required this.id,
    required this.startTime,
    required this.title,
    required this.createdAt,
    required this.duration,
    this.description,
    this.lastEdited,
    this.amountOfCustomers,
    List<User> hairDressers = const [],
    List<User> customers = const [],
  }) {
    description = 'Missing';
    lastEdited = DateTime.now();
    amountOfCustomers = 0;
  }

  Set<String> getDuration() {
    return <String>{startTime.toString(), startTime.add(duration).toString()};
  }

        duration = json['duration'],
      'duration': duration,
  }
}
