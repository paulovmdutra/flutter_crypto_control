import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String value)? onChanged;

  const SearchField(
      {super.key, this.hintText, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          //contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //filled: true,
          hintText: hintText ?? "Pesquisar...",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
