import "package:medfind_flutter/Domain/_Shared/shared.dart";
import "package:medfind_flutter/Domain/Reservation/model.dart";

class VOPharmacy extends ValueObject<Pharmacy> {
  const VOPharmacy(Pharmacy value) : super(value);
}

class VOMedPack extends ValueObject<MedPack> {
  const VOMedPack(MedPack value) : super(value);

  @override
  MedPack get() => super.get();
}
