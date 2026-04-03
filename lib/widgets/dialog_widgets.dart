import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

Future<void> showMessageDialog(String message, BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

Future<void> showErrorDialog(
  CommonResult<dynamic> result,
  BuildContext context,
) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: Text(result.message!),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

Future<void> showExitDialog(
  BuildContext context, {
  Function()? onPressed,
}) async {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Sair'),
      content: const Text('Deseja realmente sair da sessão?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancela
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Fecha o dialog
            if (onPressed != null) {
              onPressed.call();
            }
          },
          child: const Text('Sim, sair'),
        ),
      ],
    ),
  );
}

Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  /*  void Function()? onConfirm,
  void Function()? onCancel,*/
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Não"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Sim"),
        ),
      ],
    ),
  );
}
