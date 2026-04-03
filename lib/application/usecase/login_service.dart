import 'package:flutter_crypto_control/application/usecase/ilogin_service.dart';
import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/view_model/login_view_model.dart';

class LoginService extends ILoginService {
  @override
  Future<ServiceResult> login(LoginViewModel loginViewModel) async {
    final resultApplication = ServiceResult();
    return resultApplication;
  }
}
