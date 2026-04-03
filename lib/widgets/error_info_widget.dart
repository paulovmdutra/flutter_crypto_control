import 'package:flutter/material.dart';

class ErrorInfoWidget extends StatelessWidget {
  final ErrorDescription? error;

  const ErrorInfoWidget({super.key, required this.onReload, this.error});

  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          Text('Erro ao carregar categorias:\n$error'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onReload,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
