import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/main.dart';
import 'package:flutter_crypto_control/widgets/app_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConsumerScaffold extends AppStatefulWidget {
  final String? title;
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// A button displayed floating above [body], in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  final Widget? floatingActionButton;

  AppConsumerScaffold({
    super.key,
    this.scaffoldKey,
    required this.title,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(title ?? ""),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          actions: [
            IconButton(
              icon: Icon(
                theme.brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
            searchAnchor, // O ícone de pesquisa que abre a experiência SearchAnchor
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => print('Abrir Perfil / Sair (Autenticação)'),
            ),
          ],
        ),
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        body: body,
      ),
    );
  }
}
