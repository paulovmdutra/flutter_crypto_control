import 'package:flutter/material.dart';

class HelperWidgets {
  HelperWidgets._();

  static Widget builderTextFormField(TextEditingController controller,
      String labelText, String? Function(String? value) validator) {
    return builderTextFormFieldV2(controller, labelText, validator, null);
  }

  static Widget builderTextFormFieldV2(
      TextEditingController controller,
      String labelText,
      String? Function(String? value) validator,
      void Function()? onTap) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      controller: controller,
      onTap: onTap,
      validator: validator,
    );
  }

  static Widget builderTextField(
      TextEditingController controller, String hintText) {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
          ),
        )
      ],
    );
  }

  Widget builderTextFormFieldSearch(
      String labelText, TextEditingController controller,
      {bool autofocus = false,
      String? Function(String? value)? validator,
      Function(String? value)? onSaved,
      void Function()? onTap,
      Widget? suffixIcon}) {
    return builderTextFormTextField(labelText, controller,
        autofocus: autofocus,
        validator: validator,
        onSaved: onSaved,
        onTap: onTap,
        suffixIcon: const Icon(Icons.search));
  }

  Widget builderTextFormTextField(
      String labelText, TextEditingController controller,
      {bool autofocus = false,
      bool readOnly = false,
      String? Function(String? value)? validator,
      Function(String? value)? onSaved,
      void Function()? onTap,
      Widget? suffixIcon}) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      autofocus: autofocus,
      decoration: InputDecoration(labelText: labelText, suffixIcon: suffixIcon),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
    );
  }

  static ListTile builderListTile(BuildContext context,
      {bool selected = false,
      IconData icon = Icons.home,
      String title = "None",
      String rota = ""}) {
    return ListTile(
        leading: Icon(icon),
        title: Text(title),
        selected: selected,
        onTap: () {
          // Verifica se a rota está definida na tabela de rotas
          bool isValidRoute = ModalRoute.of(context)?.settings.name == rota;
          if (isValidRoute) {
            Navigator.pushNamed(context, rota);
          } else {
            Navigator.pop(context);
          }
        });
  }
}
