class Pharmacy {
  int pharmacyId;
  String pharmacyName;
  String location;

  Pharmacy(this.pharmacyId, this.pharmacyName, this.location);

  factory Pharmacy.fromJson(Map<String, dynamic> pharmacyJson) {
    return Pharmacy(int.parse(pharmacyJson['id']), pharmacyJson['name'],
        pharmacyJson['address']);
  }
}
