import 'package:uuid/uuid.dart';

String generateNewUUID() {
  return const Uuid().v4();
}
