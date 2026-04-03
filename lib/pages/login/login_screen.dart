import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/pages/login/login_form_widgets.dart';
import 'package:flutter_crypto_control/core/routes.dart';
import 'package:flutter_crypto_control/service_locator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/';

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  UserController loginController =
      UserController(); /*ServiceLocator.instance.getService(
    ServiceKeys.controllerUser.name,
  );*/

  bool isLoading = false;
  void submit() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, AppRoutes.homePage);
  }

  @override
  void initState() {
    super.initState();
    loginController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoginFormWidget(
          loginController: loginController,
          onSubmit: submit,
        ),
      ),
    );
  }
}
