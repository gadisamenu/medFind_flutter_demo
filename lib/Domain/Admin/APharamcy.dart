class APharmacy {
  int id;
  String name;
  String owner;
  String address;
  String? location;

  APharmacy(this.id, this.name, this.owner, this.address, {this.location});

  factory APharmacy.fromJson(Map<String, dynamic> pharmacyJson) {
    return APharmacy(int.parse(pharmacyJson['id']), pharmacyJson['name'],
        pharmacyJson['owner'], pharmacyJson['address'],
        location: pharmacyJson["location"]);
  }

  factory APharmacy.fromQuery(Map<String, Object?> pharmacyJson) {
    return APharmacy(
        int.parse(pharmacyJson['id'].toString()),
        pharmacyJson['name'].toString(),
        pharmacyJson['owner'].toString(),
        pharmacyJson['address'].toString(),
        location: pharmacyJson["location"].toString());
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.addAll({
      "id": id,
      "name": name,
      "owner": owner,
      "address": address,
    });
    if (location != null) {
      json.addAll({"location": location});
    }
    return json;
  }

  bool validate() {
    return ((name.length > 5) && (address.length > 10));
  }
}
