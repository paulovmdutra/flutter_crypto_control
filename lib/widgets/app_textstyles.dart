import 'package:flutter/material.dart';
import 'app_colors.dart';

// Defina sua fonte primária para a aplicação.
// Por exemplo, 'Inter' ou 'Sora' (Sora é uma fonte popular em projetos crypto/web3).
// Certifique-se de importar a fonte no seu `pubspec.yaml` primeiro.
const String _fontFamily = 'Inter';

/// [AppTextStyles] constants which represent the text styles for this app
///
/// {@tool snippet}
///
/// To select a constant color can used directly. For example:
///
/// ```dart
/// TextStyle selection = AppTextStyles.smalText
/// ```
/// {@end-tool}
abstract class AppTextStyles {
  AppTextStyles._();

  /// A tiny-sized text style used for very small text elements.
  ///
  /// This style uses a font size of 8, bold weight, and white color.
  static const TextStyle tinyText = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// A small-sized text style used for smaller text elements.
  ///
  /// This style uses a font size of 12, bold weight, and white color.
  static const TextStyle smallText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// A large-sized text style used for more prominent text elements.
  ///
  /// This style uses a font size of 18, bold weight, and white color.
  static const TextStyle largeText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  /// A big-sized text style used for very large text elements.
  ///
  /// This style uses a font size of 24, bold weight, and white color.
  static const TextStyle bigText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Estilo base para garantir consistência de fonte em todos.
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: _fontFamily,
    color: textColor,
  );

  // --- Títulos e Cabeçalhos ---

  static TextStyle headline1 = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700, // Bold
  );

  static TextStyle headline2 = _baseStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  static TextStyle sectionTitle = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
  );

  // --- Texto Comum (Body) ---

  static TextStyle bodyText = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
  );

  static TextStyle bodyTextBold = bodyText.copyWith(
    fontWeight: FontWeight.w600, // Semi-Bold
  );

  static TextStyle caption = _baseStyle.copyWith(
    fontSize: 14,
    color: textSecondaryColor, // Usado para detalhes menores
    fontWeight: FontWeight.w400,
  );

  // --- Estilos Específicos de Finanças (Valores e Percentuais) ---

  // Valor Principal (Ex: Saldo total)
  static TextStyle mainValue = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  // Valor de Ganho (Preço subiu)
  static TextStyle valuePositive = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: positiveColor,
  );

  // Valor de Perda (Preço caiu)
  static TextStyle valueNegative = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: negativeColor,
  );

  // Estilo para Tickers de Criptomoedas (BTC, ETH, etc.)
  static TextStyle tickerSymbol = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textSecondaryColor,
  );

  // --- Botões e Componentes ---

  static TextStyle buttonPrimary = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color:
        white, // Cor do texto em um botão primário (fundo geralmente colorido)
  );

  static TextStyle chipLabel = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
