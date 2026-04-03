import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adiciona um fundo escuro semi-transparente para focar no loader
      backgroundColor: Colors.black.withAlpha(50),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Column(
            mainAxisSize:
                MainAxisSize.min, // Ocupa o mínimo de espaço na coluna
            children: [
              // Personaliza a cor do indicador
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                strokeWidth: 4, // Espessura da linha
              ),
              SizedBox(height: 15),
              Text(
                'Carregando...',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<String?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Enquanto carrega
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          return widgetBuilder;
          /*else if (snapshot.hasData && snapshot.data != null) {
            return Center(child: Text('Token: ${snapshot.data}'));
          } else {
            return const Center(child: Text('Nenhum token encontrado.'));
          }*/
        },
      ),
    );
  }*/
}
