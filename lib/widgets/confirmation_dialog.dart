// NOVO WIDGET: Diálogo de Confirmação
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/widgets/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancelar
          child: const Text('Cancelar'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.expense),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // Fechar após a confirmação
          },
          child: const Text('Confirmar Exclusão'),
        ),
      ],
    );
  }
}
