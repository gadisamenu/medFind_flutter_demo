class Pill {
  int pillId;

  String medicineName;
  int strength;
  int amount;

  Pill(this.pillId, this.medicineName, this.strength, this.amount);

  factory Pill.fromJson(Map<String, dynamic> medpackJson) {
    return Pill(medpackJson['id'], medpackJson['medicine']['name'],
        medpackJson['strength'], medpackJson['amount']);
  }

  Map<String, Object> toJson() {
    return {
      'id': pillId,
      'medicineName': medicineName,
      'strength': strength,
      'amount': amount
    };
  }
}
