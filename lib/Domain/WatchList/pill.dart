import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';

class Pill{
  int pillId;

  MedicineName name;
  int strength;
  int amount;

  Pill(this.pillId, this.name, this.strength, this.amount);
  factory Pill.fromJson(Map<String, dynamic> medpackJson) {
    MedicineName medName = MedicineName(medpackJson['medicine']['name']);

    return Pill(medpackJson['id'], medName, medpackJson['strength'],
        medpackJson['amount']);
  }

  bool validate() {
    return name.isValid() &&
        (strength > 20 && strength < 1000) &&
        (amount > 6 && amount < 100);
  }

  Map<String, Object> toJson() {
    return {
      'id': pillId,
      'medicineName': name.get(),
      'strength': strength,
      'amount': amount
    };
  }

   @override
  bool operator ==(Object other) {
    return other is Pill && other.pillId == pillId;
  }

  // @override
  // int get hashCode => Object.hash(object1, object2)
}
