import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/shared/utils/formatter/date_input_formatter.dart';
import 'package:flutter_crypto_control/shared/utils/formatter/phone_input_formatter.dart';
import 'package:flutter_crypto_control/view_model/usuario_view_model.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class RegisterUserFormWidget extends StatefulWidget {
  final UserController userController;
  final VoidCallback onSubmit;

  const RegisterUserFormWidget({
    required this.userController,
    required this.onSubmit,
    super.key,
  });

  @override
  State<RegisterUserFormWidget> createState() => _RegisterUserFormWidgetState();
}

class _RegisterUserFormWidgetState extends State<RegisterUserFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Sincroniza a data formatada no campo de texto quando o ValueNotifier muda
    widget.userController.usuarioViewModel.dataNotifier.addListener(() {
      final date = widget.userController.usuarioViewModel.dataNotifier.value;
      widget.userController.usuarioViewModel.dataNascimentoController.text =
          date != null
          ? '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}'
          : '';
    });
    preencherControllersComDadosFicticios();
  }

  ///Valida todos os dados do formulário de login
  void submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() => isLoading = true);
    var result = await widget.userController.save();

    // Verifica se o widget ainda está montado
    if (!mounted) return;

    if (!result.success) {
      // showErrorDialog(result, context);
      setState(() => isLoading = false);
      return;
    }

    setState(() => isLoading = false);

    await showMessageDialog("Salvo com sucesso", context);

    widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Center(child: CircularProgress());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _buildForm(context, screenHeight),
    );
  }

  void preencherControllersComDadosFicticios() {
    UserController userController = widget.userController;
    UsuarioViewModel viewModel = userController.usuarioViewModel;
    viewModel.nomeController.text = 'João da Silva';
    viewModel.loginController.text = 'joaosilva';
    viewModel.emailController.text = 'joao@example.com';
    viewModel.telefoneController.text = '(11) 99999-1234';
    viewModel.dataNotifier.value = DateTime.tryParse(
      '1990-05-15',
    ); // formato ISO para DateTime
    viewModel.passwordController.text = 'senha123';
    viewModel.confirmPasswordController.text = 'senha123';
  }

  AppForm _buildForm(BuildContext context, screenHeight) {
    Widget spacer(double factor) => SizedBox(height: screenHeight * factor);
    return AppForm(
      focusNode: FocusScopeNode(),
      formKey: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          spacer(.12),
          const Text(
            'Criar um conta,',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          spacer(.01),
          Text(
            'Registre para entrar!',
            style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(.6)),
          ),
          spacer(.12),
          InputFormField(
            controller: widget.userController.usuarioViewModel.nomeController,
            labelText: 'Nome',
            validator: widget.userController.fieldValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            autoFocus: true,
          ),
          spacer(.025),
          InputFormField(
            controller: widget.userController.usuarioViewModel.loginController,
            labelText: 'Login',
            validator: widget.userController.loginValidator,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autoFocus: true,
          ),
          spacer(.025),
          InputFormField(
            controller: widget.userController.usuarioViewModel.emailController,
            labelText: 'Email',
            validator: widget.userController.emailValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autoFocus: true,
          ),
          spacer(.025),
          InputFormField(
            controller:
                widget.userController.usuarioViewModel.telefoneController,
            labelText: 'Telefone',
            validator: widget.userController.fieldValidator,
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
                  controller: widget
                      .userController
                      .usuarioViewModel
                      .dataNascimentoController,
                  labelText: 'Data nascimento',
                  validator: widget.userController.fieldValidator,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [DateInputFormatter()],
                  autoFocus: true,
                ),
              ),
            ),
          ),
          spacer(.025),
          InputFormField(
            controller:
                widget.userController.usuarioViewModel.passwordController,
            labelText: 'Senha',
            validator: widget.userController.passwordValidator,
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
            controller: widget
                .userController
                .usuarioViewModel
                .confirmPasswordController,
            labelText: 'Confirmar Senha',
            validator: widget.userController.passwordValidator,
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
          FormButton(text: 'Registrar', onPressed: submit),
          spacer(.125),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: RichText(
              text: const TextSpan(
                text: "Já estou registrado, ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Logar',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          widget.userController.usuarioViewModel.dataNotifier.value ??
          DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      widget.userController.usuarioViewModel.dataNotifier.value = picked;
    }
  }
}
