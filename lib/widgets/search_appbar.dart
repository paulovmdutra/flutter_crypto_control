import 'package:flutter/material.dart';

class SearchAppBarExample extends StatefulWidget {
  const SearchAppBarExample({super.key});

  @override
  State<SearchAppBarExample> createState() => _SearchAppBarExampleState();
}

class _SearchAppBarExampleState extends State<SearchAppBarExample> {
  // 1. Estado para controlar se o campo de pesquisa está ativo
  bool _isSearching = false;

  // 2. Controller para gerenciar o texto do campo de pesquisa
  final TextEditingController _searchController = TextEditingController();

  // 3. Widget que define o título ou o campo de pesquisa
  Widget _buildTitleWidget() {
    if (_isSearching) {
      return TextField(
        controller: _searchController,
        autofocus: true, // Foca automaticamente ao entrar no modo de pesquisa
        decoration: const InputDecoration(
          hintText: "Pesquisar...",
          border: InputBorder.none, // Remove a borda padrão do TextField
          hintStyle: TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 18.0),
        onChanged: (text) {
          // Aqui você pode chamar a função para filtrar seus dados
          print("Pesquisando por: $text");
        },
      );
    } else {
      return const Text("Meu Aplicativo"); // Título padrão
    }
  }

  // 4. Widget que define os botões de ação (Actions)
  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        // Botão para limpar e fechar o modo de pesquisa
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ),
      ];
    } else {
      return [
        // Botão para entrar no modo de pesquisa
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _buildTitleWidget(), // Usa o widget que alterna entre título e campo
        actions:
            _buildActions(), // Usa os botões que alternam entre pesquisa/fechar
      ),
      body: const Center(child: Text('Conteúdo Principal')),
    );
  }
}
