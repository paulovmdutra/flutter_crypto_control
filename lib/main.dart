import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/routes.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  setupWidgets();
  setupRepositories(mode: RepositoryMode.fake);
  setupControllers();
  runApp(ProviderScope(child: MainApp(prefs: prefs)));
}

class MainApp extends ConsumerWidget {
  final SharedPreferences prefs;
  const MainApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // observa o estado atual do tema
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      theme: theme,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Provider responsável pelo estado do tema atual (ThemeData)
final themeProvider = StateNotifierProvider<ThemeController, ThemeData>((ref) {
  return ThemeController();
});

/// Controlador do tema, similar a um Cubit do BLoC
class ThemeController extends StateNotifier<ThemeData> {
  ThemeController() : super(_lightTheme);

  static final _lightTheme = AppTheme.defaultTheme();

  static final _darkTheme = ThemeData.dark();

  /// Alterna entre o tema claro e escuro
  void toggleTheme() {
    state = state.brightness == Brightness.dark ? _lightTheme : _darkTheme;
  }
}
