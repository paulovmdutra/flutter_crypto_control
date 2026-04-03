import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/domain/models/usuario.dart';
import 'package:flutter_crypto_control/pages/app/generic_form_screen.dart';
import 'package:flutter_crypto_control/widgets/form_button.dart';
import 'package:flutter_crypto_control/widgets/input_field.dart';
import 'package:flutter_crypto_control/shared/utils/util.dart';


class ChangePasswordFormScreen extends StatefulWidget {
  static const String routeName = '/changepassword_form_screen';

  const ChangePasswordFormScreen({super.key});

  @override
  State<ChangePasswordFormScreen> createState() =>
      ChangePasswordFormScreenState();
}

class ChangePasswordFormScreenState extends State<ChangePasswordFormScreen> {
  UsuarioController controller = UsuarioController();

  final GlobalKey<GenericFormScreenState<Usuario, UsuarioController>>
      _formScreenKey = GlobalKey();

  bool _obscurePassword = true;
  @override
  void initState() {
    super.initState();
    // Dê um pequeno atraso para garantir que o contexto está pronto
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is! Bundle) {
        throw Exception('Argumentos inválidos para formulário!');
      }
      final control = args.get("controller");
      if (control is! UsuarioController) {
        throw Exception('Controller inválido ou ausente no formulário!');
      }

      controller = control;
      setState(() {}); // Força o rebuild
    });
  }

  Future<ServiceResult> onActionSubmit() async {
    return ServiceResult(success: true);
  }

  @override
  Widget build(BuildContext context) {
    return GenericFormScreen<Usuario, UsuarioController>(
      key: _formScreenKey,
      controller: controller,
      title: controller.title,
      onActionSubmit: onActionSubmit,
      buildForm: () => buildUsuarioForm(),
      onSuccess: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildUsuarioForm() {
    final screenHeight = MediaQuery.of(context).size.height;
    Widget spacer(double factor) => SizedBox(height: screenHeight * factor);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        spacer(.12),
        const Text(
          'Alterar senha,',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        spacer(.01),
        Text(
          'Informe a nova senha!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black.withOpacity(.6),
          ),
        ),
        spacer(.12),
        InputFormField(
          controller: controller.usuarioViewModel.passwordController,
          labelText: 'Senha',
          validator: controller.passwordValidator,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.next,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        spacer(.025),
        InputFormField(
          controller: controller.usuarioViewModel.confirmPasswordController,
          labelText: 'Confirmar Senha',
          validator: controller.passwordValidator,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        spacer(.075),
        FormButton(
          text: 'Confirmar',
          onPressed: () {
            _formScreenKey.currentState?.submitForm();
          },
        ),
      ],
    );
  }
}
