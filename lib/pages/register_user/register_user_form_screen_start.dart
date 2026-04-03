import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/pages/register_user/register_user_form_widget.dart';
import 'package:flutter_crypto_control/service_locator.dart';

class RegisterUserFormScreenStart extends StatefulWidget {
  const RegisterUserFormScreenStart({super.key});

  @override
  State<RegisterUserFormScreenStart> createState() =>
      _RegisterUserFormScreenStartState();
}

class _RegisterUserFormScreenStartState
    extends State<RegisterUserFormScreenStart>
    with TickerProviderStateMixin {
  UserController registerUserController =
      UserController(); /* ServiceLocator.instance.getService(
    ServiceKeys.controllerUser.name,
  );*/

  bool isLoading = false;

  void submit() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RegisterUserFormWidget(
          userController: registerUserController,
          onSubmit: submit,
        ),
      ),
    );
  }
}
