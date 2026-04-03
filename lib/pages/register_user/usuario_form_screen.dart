import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/domain/models/usuario.dart';
import 'package:flutter_crypto_control/pages/app/generic_form_screen.dart';
import 'package:flutter_crypto_control/widgets/form_button.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';
import 'package:flutter_crypto_control/routes.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/utils/formatter/date_input_formatter.dart';
import 'package:flutter_crypto_control/shared/utils/formatter/phone_input_formatter.dart';
import 'package:flutter_crypto_control/shared/utils/util.dart';

class UsuarioFormScreen extends StatefulWidget {
  static const String routeName = '/usuario_form_screen';

  const UsuarioFormScreen({super.key});

  @override
  State<UsuarioFormScreen> createState() => UsuarioFormScreenState();
}

class UsuarioFormScreenState extends State<UsuarioFormScreen> {
  final UsuarioController controller =
      UsuarioController(); /* ServiceLocator.instance.getService(
    ServiceKeys.controllerUser.name,
  );*/

  final GlobalKey<GenericFormScreenState<Usuario, UsuarioController>>
  _formScreenKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Sincroniza a data formatada no campo de texto quando o ValueNotifier muda
    controller.usuarioViewModel.dataNotifier.addListener(() {
      final date = controller.usuarioViewModel.dataNotifier.value;
      controller.usuarioViewModel.dataNascimentoController.text = date != null
          ? '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}'
          : '';
    });
  }

  Future<ServiceResult> onActionSubmit() async {
    final result = await controller.save();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GenericFormScreen<Usuario, UsuarioController>(
      key: _formScreenKey,
      controller: controller,
      title: controller.title,
      onActionSubmit: onActionSubmit,
      buildForm: () => buildUsuarioForm(),
      actionsButtons: [
        TextButton.icon(
          onPressed: () async {
            Bundle bundle = Bundle()..put(Argument.entity, controller.usuario);
            bundle.put("controller", controller);
            await Navigator.pushNamed(
              context,
              Routes.changePasswordFormPage,
              arguments: bundle,
            );
            setState(() {});
          },
          icon: const Icon(Icons.password),
          label: const Text("Trocar senha"),
        ),
      ],
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
        spacer(0.10),
        InputFormField(
          controller: controller.usuarioViewModel.nomeController,
          labelText: 'Nome',
          validator: controller.fieldValidator,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          autoFocus: true,
        ),
        spacer(.025),
        InputFormField(
          controller: controller.usuarioViewModel.loginController,
          labelText: 'Login',
          validator: controller.loginValidator,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autoFocus: true,
        ),
        spacer(.025),
        InputFormField(
          controller: controller.usuarioViewModel.emailController,
          labelText: 'Email',
          validator: controller.emailValidator,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autoFocus: true,
        ),
        spacer(.025),
        InputFormField(
          controller: controller.usuarioViewModel.telefoneController,
          labelText: 'Telefone',
          validator: controller.fieldValidator,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: [PhoneInputFormatter()],
          autoFocus: true,
        ),
        spacer(.025),
        // Campo de data
        InkWell(
          child: GestureDetector(
            onTap: _selectDate,
            child: AbsorbPointer(
              child: InputFormField(
                controller:
                    controller.usuarioViewModel.dataNascimentoController,
                labelText: 'Data nascimento',
                validator: controller.fieldValidator,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                inputFormatters: [DateInputFormatter()],
                autoFocus: true,
              ),
            ),
          ),
        ),

        spacer(0.05),
        FormButton(
          text: controller.usuario == null ? 'Salvar' : 'Atualizar',
          onPressed: () {
            _formScreenKey.currentState?.submitForm();
          },
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          controller.usuarioViewModel.dataNotifier.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.usuarioViewModel.dataNotifier.value = picked;
    }
  }
}
