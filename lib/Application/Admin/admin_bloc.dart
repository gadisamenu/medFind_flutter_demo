import 'package:bloc/bloc.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Infrastructure/Admin/Repository/admin_repository.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/return_data_type.dart';
part 'admin_event.dart';
part 'admin_state.dart';

class AdminBlock extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepo;
  AdminBlock(this.adminRepo) : super(Idle()) {
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

  //_____________________ users ______________\\
  // load users
  void _loadUsers(LoadUsers event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.getUsers();
    if (!result.hasError) {
      emit(UsersLoaded(result.value));
    } else {
      emit(LoadingFailed(msg: "Error loading Users"));
    }
  }

  //retrive a user
  void _loadUser(LoadUser event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.getUser(event.id);

    if (!result.hasError) {
      emit(UserLoaded(result.value));
    } else {
      emit(LoadingFailed(msg: "Error loading  user"));
    }
  }

  //
  void _updateUser(UpdateUser event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.updateUser(event.user.id!, event.user);

    if (!result.hasError) {
      emit(UserLoaded(result.value));
    } else {
      emit(UpdateFailed(msg: "Error on update"));
    }
  }

  void _deleteUser(DeleteUser event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.removeUser(event.id);
    if (!result.hasError) {
      emit(UserDeleted(event.id));
    } else {
      emit(DeleteFailed(msg: "Error while deleting " + result.error));
    }
  }

  void _changeRole(ChangerRole event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.changeRole(event.id, event.role);

    if (!result.error) {
      emit(RoleChanged(result.value));
    } else {
      emit(ChangeFailed());
    }
  }

  //____________________ pharmacies ________________\\

  void _loadPharmacies(LoadPharmacies event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.getPharmacies();
    if (!result.hasError) {
      emit(UsersLoaded(result.value));
    } else {
      emit(LoadingFailed(msg: "Error loading Pharmacies"));
    }
  }

  void _loadPharmacy(LoadPharmacy event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.getPharmacy(event.id);

    if (!result.hasError) {
      emit(UserLoaded(result.value));
    } else {
      emit(LoadingFailed(msg: "Error loading pharmacy"));
    }
  }

  void _deletePharmacy(DeletePharmacy event, Emitter emit) async {
    Return result = await adminRepo.removePharmacy(event.id);
    if (!result.hasError) {
      emit(UserDeleted(event.id));
    } else {
      emit(DeleteFailed(msg: "Error while deleting " + result.error));
    }
  }

  void _updatePharmacy(UpdatePharmacy event, Emitter emit) async {
    emit(Loading());
    Return result = await adminRepo.updatePharmacy(
        event.pharmacy.pharmacyId, event.pharmacy);

    if (!result.hasError) {
      emit(UserLoaded(result.value));
    } else {
      emit(UpdateFailed(msg: "Error on update"));
    }
  }
}
