import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget>? children;
  final Widget? child;
  final FocusScopeNode? focusNode;

  const AppForm({
    super.key,
    this.children,
    this.child,
    required this.formKey,
    required this.focusNode,
  });

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: widget.focusNode,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(key: widget.formKey, child: _formBody()),
      ),
    );
  }

  Widget _formBody() {
    return widget.child ?? ListView(children: widget.children ?? []);
  }
}
