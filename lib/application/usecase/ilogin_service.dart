import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/view_model/login_view_model.dart';

abstract class ILoginService {
  Future<ServiceResult> login(LoginViewModel loginViewModel);
}
