import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final String? title;
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final List<Widget>? actions;

  /// A button displayed floating above [body], in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  final Widget? floatingActionButton;

  AppScaffold({
    super.key,
    this.scaffoldKey,
    required this.title,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.actions,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final SearchAnchor searchAnchor = SearchAnchor(
    builder: (BuildContext context, SearchController controller) {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          controller.openView(); // Abre a tela de pesquisa
        },
      );
    },
    suggestionsBuilder:
        (BuildContext context, SearchController controller) async {
          // Lista de sugestões de pesquisa
          return <Widget>[
            ListTile(title: Text('Sugestão 1')),
            ListTile(title: Text('Sugestão 2')),
          ];
        },
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      searchAnchor, // O ícone de pesquisa que abre a experiência SearchAnchor
      IconButton(
        icon: const Icon(Icons.account_circle),
        onPressed: () => print('Abrir Perfil / Sair (Autenticação)'),
      ),
    ];

    if (widget.actions != null) {
      for (var element in widget.actions!) {
        actions.add(element);
      }
    }

    return SafeArea(
      child: Scaffold(
        key: widget.scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          actions: actions,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        drawer: widget.drawer,

        bottomNavigationBar: widget.bottomNavigationBar,
        // floatingActionButton: widget.floatingActionButton,
        body: widget.body,
      ),
    );
  }
}
