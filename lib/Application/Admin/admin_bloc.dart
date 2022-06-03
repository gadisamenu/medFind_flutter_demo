import 'package:bloc/bloc.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
part 'admin_event.dart';
part 'admin_state.dart';

class AdminBlock extends Bloc<AdminEvent, AdminState> {
  AdminBlock() : super(Idle()) {
    on<LoadUsers>(_loadUsers);
    on<LoadUser>(_loadUser);
    on<UpdateUser>(_updateUser);
    on<DeleteUser>(_deleteUser);
    on<ChangerRole>(_changeRole);
    on<LoadPharmacies>(_loadPharmacies);
    on<LoadPharmacy>(_loadPharmacy);
    on<DeletePharmacy>(_deletePharmacy);
    on<UpdatePharmacy>(_updatePharmacy);
  }

  Future<void> _loadUsers(LoadUsers event, Emitter emit) async {}
  Future<void> _loadUser(LoadUser event, Emitter emit) async {}
  Future<void> _updateUser(UpdateUser event, Emitter emit) async {}
  Future<void> _deleteUser(DeleteUser event, Emitter emit) async {}
  Future<void> _changeRole(ChangerRole event, Emitter emit) async {}

  Future<void> _loadPharmacies(LoadPharmacies event, Emitter emit) async {}

  Future<void> _loadPharmacy(LoadPharmacy event, Emitter emit) async {}

  Future<void> _deletePharmacy(DeletePharmacy event, Emitter emit) async {}

  Future<void> _updatePharmacy(UpdatePharmacy event, Emitter emit) async {}
}
