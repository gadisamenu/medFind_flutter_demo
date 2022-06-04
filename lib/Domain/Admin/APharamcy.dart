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
}
