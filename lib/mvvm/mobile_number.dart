import 'package:bzinga/authentication/models/registerMobileNumber.dart';
import 'package:scoped_model/scoped_model.dart';

class RegMobNumber {}

class MobViewModel extends Model {
  Future<MobileRegisterResponse> _regModNumber;

  Future<MobileRegisterResponse> get regModNumber => _regModNumber;

  set regModNumber(Future<MobileRegisterResponse> response) {
    _regModNumber = response;
    notifyListeners();
  }
}
