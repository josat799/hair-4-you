import 'package:backend/backend.dart';

Future main() async {
  final app = Application<Hair4YouChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print(
      "Application started on ip: ${app.options.address} port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
