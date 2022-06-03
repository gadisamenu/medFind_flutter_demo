import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';

class Pill {
  int pillId;

  // String medicineName;
  MedicineName name;
  int strength;
  int amount;

  Pill(this.pillId, this.name, this.strength, this.amount);

  factory Pill.fromJson(Map<String, dynamic> medpackJson) {
    MedicineName medName = MedicineName(medpackJson['medicine']['name']);
    return Pill(medpackJson['id'], medName,
        medpackJson['strength'], medpackJson['amount']);
  }

  Map<String, Object> toJson() {
    return {
      'id': pillId,
      'medicineName': name.get(),
      'strength': strength,
      'amount': amount
    };
  }
}
