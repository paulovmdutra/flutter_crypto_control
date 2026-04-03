import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class GenericModel<T> {
  final List<T?> entities;
  GenericModel({required this.entities});
}

class GenericContainerPage extends StatefulWidget {
  final Widget? containerPage;
  final String title;

  const GenericContainerPage({
    super.key,
    required this.containerPage,
    required this.title,
  });

  @override
  State createState() => _GenericContainerPageState();
}

class _GenericContainerPageState extends State<GenericContainerPage> {
  @override
  Widget build(BuildContext context) {
    return widget.containerPage ??
        const Center(child: Text('Nenhum container disponível'));
  }
}

abstract class GenericPage extends StatefulWidget {
  final String title;
  const GenericPage({super.key, required this.title});
  Widget? build(BuildContext context);
  @override
  State createState() => _GenericPageState();
}

class _GenericPageState extends State<GenericPage> {
  // **Novo método para selecionar e exibir o tipo de formulário**
  Widget _selectTypeForm(DisplayType type) {
    Widget? containerPage =
        widget.build(context) ??
        const Center(child: Text('Nenhum container disponível'));
    switch (type) {
      case DisplayType.scaffold:
        return AppScaffold(title: widget.title, body: containerPage);
      case DisplayType.bottomSheet:
        return const Center(child: Text('Nenhum container disponível'));
      case DisplayType.dialog:
        return const Center(child: Text('Nenhum container disponível'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _selectTypeForm(DisplayType.scaffold);
  }
}
