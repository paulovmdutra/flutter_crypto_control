import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// Um componente TextField customizado para formulários
///
class InputFormField extends StatelessWidget {
  final String? labelText;
  final String? forceErrorText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String? value)? validator;
  final String? errorText;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  TextCapitalization textCapitalization = TextCapitalization.none;
  final int? maxLength;
  final bool autoFocus;
  final bool obscureText;
  InputFormField(
      {this.labelText,
      this.forceErrorText,
      this.controller,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.errorText,
      this.hintText,
      this.keyboardType,
      this.textInputAction,
      this.autoFocus = false,
      this.obscureText = false,
      this.suffixIcon,
      this.textCapitalization = TextCapitalization.none,
      this.maxLength,
      this.inputFormatters,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      forceErrorText: forceErrorText,
      autofocus: autoFocus,
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        errorText: errorText,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        /*border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),*/
      ),
    );
  }
}
