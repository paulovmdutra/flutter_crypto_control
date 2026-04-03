import 'package:flutter/material.dart';

// Defina as cores comuns no seu app (ajuste conforme o tema).
// Em apps financeiros, as cores indicam estado: positivo (verde), negativo (vermelho)
// e neutro (cinza/branco/preto).
const Color primaryColor = Color(0xFF007AFF); // Azul primário (ex: botões)
const Color textColor = Color(
  0xFF1E293B,
); // Texto escuro (Quase preto/cinza escuro)
const Color textSecondaryColor = Color(
  0xFF64748B,
); // Texto secundário (Cinza médio)
const Color positiveColor = Color(0xFF10B981); // Verde para ganhos
const Color negativeColor = Color(0xFFEF4444); // Vermelho para perdas
const Color white = Colors.white; // Branco

class AppColors {
  // --- UTILITY / BASE COLORS ---
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // --- RED ---
  static const Color red50 = Color(0xFFFEECEB);
  static const Color red100 = Color(0xFFF8B5B3);
  static const Color red200 = Color(0xFFF3807D);
  static const Color red300 = Color(0xFFEF4C49);
  static const Color red400 = Color(0xFFEB221E);
  static const Color red500 = Color(0xFFE80000);
  static const Color red600 = Color(0xFFE40000);
  static const Color red700 = Color(0xFFE10000);
  static const Color red800 = Color(0xFFDE0000);
  static const Color red900 = Color(0xFFD90000);
  static const Color redA100 = Color(0xFFFF8A80);
  static const Color redA200 = Color(0xFFFF5252);
  static const Color redA400 = Color(0xFFFF1744);
  static const Color redA700 = Color(0xFFD50000);

  // --- PINK ---
  static const Color pink50 = Color(0xFFFCE4EC);
  static const Color pink100 = Color(0xFFF8BBD0);
  static const Color pink200 = Color(0xFFF48FB1);
  static const Color pink300 = Color(0xFFF06292);
  static const Color pink400 = Color(0xFFEC407A);
  static const Color pink500 = Color(0xFFE91E63);
  static const Color pink600 = Color(0xFFD81B60);
  static const Color pink700 = Color(0xFFC2185B);
  static const Color pink800 = Color(0xFFAD1457);
  static const Color pink900 = Color(0xFF880E4F);
  static const Color pinkA100 = Color(0xFFFF80AB);
  static const Color pinkA200 = Color(0xFFFF4081);
  static const Color pinkA400 = Color(0xFFF50057);
  static const Color pinkA700 = Color(0xFFC51162);

  // --- PURPLE ---
  static const Color purple50 = Color(0xFFF3E5F5);
  static const Color purple100 = Color(0xFFE1BEE7);
  static const Color purple200 = Color(0xFFCE93D8);
  static const Color purple300 = Color(0xFFBA68C8);
  static const Color purple400 = Color(0xFFAB47BC);
  static const Color purple500 = Color(0xFF9C27B0);
  static const Color purple600 = Color(0xFF8E24AA);
  static const Color purple700 = Color(0xFF7B1FA2);
  static const Color purple800 = Color(0xFF6A1B9A);
  static const Color purple900 = Color(0xFF4A148C);
  static const Color purpleA100 = Color(0xFFEA80FC);
  static const Color purpleA200 = Color(0xFFE040FB);
  static const Color purpleA400 = Color(0xFFD500F9);
  static const Color purpleA700 = Color(0xFFAA00FF);

  // --- DEEP PURPLE ---
  static const Color deepPurple50 = Color(0xFFEDE7F6);
  static const Color deepPurple100 = Color(0xFFD1C4E9);
  static const Color deepPurple200 = Color(0xFFB39DDB);
  static const Color deepPurple300 = Color(0xFF9575CD);
  static const Color deepPurple400 = Color(0xFF7E57C2);
  static const Color deepPurple500 = Color(0xFF673AB7);
  static const Color deepPurple600 = Color(0xFF5E35B1);
  static const Color deepPurple700 = Color(0xFF512DA8);
  static const Color deepPurple800 = Color(0xFF4527A0);
  static const Color deepPurple900 = Color(0xFF311B92);
  static const Color deepPurpleA100 = Color(0xFFB388FF);
  static const Color deepPurpleA200 = Color(0xFF7C4DFF);
  static const Color deepPurpleA400 = Color(0xFF651FFF);
  static const Color deepPurpleA700 = Color(0xFF6200EA);

  // --- INDIGO ---
  static const Color indigo50 = Color(0xFFE8EAF6);
  static const Color indigo100 = Color(0xFFC5CAE9);
  static const Color indigo200 = Color(0xFF9FA8DA);
  static const Color indigo300 = Color(0xFF7986CB);
  static const Color indigo400 = Color(0xFF5C6BC0);
  static const Color indigo500 = Color(0xFF3F51B5);
  static const Color indigo600 = Color(0xFF3949AB);
  static const Color indigo700 = Color(0xFF303F9F);
  static const Color indigo800 = Color(0xFF283593);
  static const Color indigo900 = Color(0xFF1A237E);
  static const Color indigoA100 = Color(0xFF8C9EFF);
  static const Color indigoA200 = Color(0xFF536DFE);
  static const Color indigoA400 = Color(0xFF3D5AFE);
  static const Color indigoA700 = Color(0xFF304FFE);

  // --- BLUE ---
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color blue100 = Color(0xFFBBDEFB);
  static const Color blue200 = Color(0xFF90CAF9);
  static const Color blue300 = Color(0xFF64B5F6);
  static const Color blue400 = Color(0xFF42A5F5);
  static const Color blue500 = Color(0xFF2196F3);
  static const Color blue600 = Color(0xFF1E88E5);
  static const Color blue700 = Color(0xFF1976D2);
  static const Color blue800 = Color(0xFF1565C0);
  static const Color blue900 = Color(0xFF0D47A1);
  static const Color blueA100 = Color(0xFF82B1FF);
  static const Color blueA200 = Color(0xFF448AFF);
  static const Color blueA400 = Color(0xFF2979FF);
  static const Color blueA700 = Color(0xFF2962FF);

  // --- LIGHT BLUE ---
  static const Color lightBlue50 = Color(0xFFE1F5FE);
  static const Color lightBlue100 = Color(0xFFB3E5FC);
  static const Color lightBlue200 = Color(0xFF81D4FA);
  static const Color lightBlue300 = Color(0xFF4FC3F7);
  static const Color lightBlue400 = Color(0xFF29B6F6);
  static const Color lightBlue500 = Color(0xFF03A9F4);
  static const Color lightBlue600 = Color(0xFF039BE5);
  static const Color lightBlue700 = Color(0xFF0288D1);
  static const Color lightBlue800 = Color(0xFF0277BD);
  static const Color lightBlue900 = Color(0xFF01579B);
  static const Color lightBlueA100 = Color(0xFF40C4FF);
  static const Color lightBlueA200 = Color(0xFF00B0FF);
  static const Color lightBlueA400 = Color(0xFF0091EA);
  static const Color lightBlueA700 = Color(0xFF0091EA);

  // --- CYAN ---
  static const Color cyan50 = Color(0xFFE0F7FA);
  static const Color cyan100 = Color(0xFFB2EBF2);
  static const Color cyan200 = Color(0xFF80DEEA);
  static const Color cyan300 = Color(0xFF4DD0E1);
  static const Color cyan400 = Color(0xFF26C6DA);
  static const Color cyan500 = Color(0xFF00BCD4);
  static const Color cyan600 = Color(0xFF00ACC1);
  static const Color cyan700 = Color(0xFF0097A7);
  static const Color cyan800 = Color(0xFF00838F);
  static const Color cyan900 = Color(0xFF006064);
  static const Color cyanA100 = Color(0xFF84FFFF);
  static const Color cyanA200 = Color(0xFF18FFFF);
  static const Color cyanA400 = Color(0xFF00E5FF);
  static const Color cyanA700 = Color(0xFF00B8D4);

  // --- TEAL ---
  static const Color teal50 = Color(0xFFE0F2F1);
  static const Color teal100 = Color(0xFFB2DFDB);
  static const Color teal200 = Color(0xFF80CBC4);
  static const Color teal300 = Color(0xFF4DB6AC);
  static const Color teal400 = Color(0xFF26A69A);
  static const Color teal500 = Color(0xFF009688);
  static const Color teal600 = Color(0xFF00897B);
  static const Color teal700 = Color(0xFF00796B);
  static const Color teal800 = Color(0xFF00695C);
  static const Color teal900 = Color(0xFF004D40);
  static const Color tealA100 = Color(0xFFA7FFEB);
  static const Color tealA200 = Color(0xFF64FFDA);
  static const Color tealA400 = Color(0xFF1DE9B6);
  static const Color tealA700 = Color(0xFF00BFA5);

  // --- GREEN ---
  static const Color green50 = Color(0xFFE8F5E9);
  static const Color green100 = Color(0xFFC8E6C9);
  static const Color green200 = Color(0xFFA5D6A7);
  static const Color green300 = Color(0xFF81C784);
  static const Color green400 = Color(0xFF66BB6A);
  static const Color green500 = Color(0xFF4CAF50);
  static const Color green600 = Color(0xFF43A047);
  static const Color green700 = Color(0xFF388E3C);
  static const Color green800 = Color(0xFF2E7D32);
  static const Color green900 = Color(0xFF1B5E20);
  static const Color greenA100 = Color(0xFFB9F6CA);
  static const Color greenA200 = Color(0xFF69F0AE);
  static const Color greenA400 = Color(0xFF00E676);
  static const Color greenA700 = Color(0xFF00C853);

  // --- LIGHT GREEN ---
  static const Color lightGreen50 = Color(0xFFF1F8E9);
  static const Color lightGreen100 = Color(0xFFDCEDC8);
  static const Color lightGreen200 = Color(0xFFC5E1A5);
  static const Color lightGreen300 = Color(0xFFAED581);
  static const Color lightGreen400 = Color(0xFF9CCC65);
  static const Color lightGreen500 = Color(0xFF8BC34A);
  static const Color lightGreen600 = Color(0xFF7CB342);
  static const Color lightGreen700 = Color(0xFF689F38);
  static const Color lightGreen800 = Color(0xFF558B2F);
  static const Color lightGreen900 = Color(0xFF33691E);
  static const Color lightGreenA100 = Color(0xFFCCFF90);
  static const Color lightGreenA200 = Color(0xFFB2FF59);
  static const Color lightGreenA400 = Color(0xFF76FF03);
  static const Color lightGreenA700 = Color(0xFF64DD17);

  // --- LIME ---
  static const Color lime50 = Color(0xFFF9FBE7);
  static const Color lime100 = Color(0xFFF0F4C3);
  static const Color lime200 = Color(0xFFE6EE9C);
  static const Color lime300 = Color(0xFFDCE775);
  static const Color lime400 = Color(0xFFD4E157);
  static const Color lime500 = Color(0xFFCDDC39);
  static const Color lime600 = Color(0xFFC0CA33);
  static const Color lime700 = Color(0xFFAFB42B);
  static const Color lime800 = Color(0xFF9FA8DA);
  static const Color lime900 = Color(0xFF827717);
  static const Color limeA100 = Color(0xFFF4FF81);
  static const Color limeA200 = Color(0xFFEEFF41);
  static const Color limeA400 = Color(0xFFC6FF00);
  static const Color limeA700 = Color(0xFFAEEA00);

  // --- YELLOW ---
  static const Color yellow50 = Color(0xFFFFFDE7);
  static const Color yellow100 = Color(0xFFFFF9C4);
  static const Color yellow200 = Color(0xFFFFF59D);
  static const Color yellow300 = Color(0xFFFFF176);
  static const Color yellow400 = Color(0xFFFFEE58);
  static const Color yellow500 = Color(0xFFFFEB3B);
  static const Color yellow600 = Color(0xFFFDD835);
  static const Color yellow700 = Color(0xFFFBC02D);
  static const Color yellow800 = Color(0xFFF9A825);
  static const Color yellow900 = Color(0xFFF57F17);
  static const Color yellowA100 = Color(0xFFFFFF8D);
  static const Color yellowA200 = Color(0xFFFFFF00);
  static const Color yellowA400 = Color(0xFFFFEA00);
  static const Color yellowA700 = Color(0xFFFFD600);

  // --- AMBER ---
  static const Color amber50 = Color(0xFFFFF8E1);
  static const Color amber100 = Color(0xFFFFECB3);
  static const Color amber200 = Color(0xFFFFE082);
  static const Color amber300 = Color(0xFFFFD54F);
  static const Color amber400 = Color(0xFFFFCA28);
  static const Color amber500 = Color(0xFFFFC107);
  static const Color amber600 = Color(0xFFFFB300);
  static const Color amber700 = Color(0xFFFFA000);
  static const Color amber800 = Color(0xFFFF8F00);
  static const Color amber900 = Color(0xFFFF6F00);
  static const Color amberA100 = Color(0xFFFFE57F);
  static const Color amberA200 = Color(0xFFFFD740);
  static const Color amberA400 = Color(0xFFFFC400);
  static const Color amberA700 = Color(0xFFFFB300);

  // --- ORANGE ---
  static const Color orange50 = Color(0xFFFFF3E0);
  static const Color orange100 = Color(0xFFFFE0B2);
  static const Color orange200 = Color(0xFFFFCC80);
  static const Color orange300 = Color(0xFFFFB74D);
  static const Color orange400 = Color(0xFFFFA726);
  static const Color orange500 = Color(0xFFFF9800);
  static const Color orange600 = Color(0xFFFB8C00);
  static const Color orange700 = Color(0xFFF57C00);
  static const Color orange800 = Color(0xFFEF6C00);
  static const Color orange900 = Color(0xFFE65100);
  static const Color orangeA100 = Color(0xFFFFD180);
  static const Color orangeA200 = Color(0xFFFFAB40);
  static const Color orangeA400 = Color(0xFFFF9100);
  static const Color orangeA700 = Color(0xFFFF6D00);

  // --- DEEP ORANGE ---
  static const Color deepOrange50 = Color(0xFFFBE9E7);
  static const Color deepOrange100 = Color(0xFFFFCCBC);
  static const Color deepOrange200 = Color(0xFFFFAB91);
  static const Color deepOrange300 = Color(0xFFFF8A65);
  static const Color deepOrange400 = Color(0xFFFF7043);
  static const Color deepOrange500 = Color(0xFFFF5722);
  static const Color deepOrange600 = Color(0xFFF4511E);
  static const Color deepOrange700 = Color(0xFFE64A19);
  static const Color deepOrange800 = Color(0xFFD84315);
  static const Color deepOrange900 = Color(0xFFBF360C);
  static const Color deepOrangeA100 = Color(0xFFFF9E80);
  static const Color deepOrangeA200 = Color(0xFFFF6E40);
  static const Color deepOrangeA400 = Color(0xFFFF3D00);
  static const Color deepOrangeA700 = Color(0xFFDD2C00);

  // --- BROWN (Sem tons de Accent) ---
  static const Color brown50 = Color(0xFFEFEBE9);
  static const Color brown100 = Color(0xFFD7CCC8);
  static const Color brown200 = Color(0xFFBCAAA4);
  static const Color brown300 = Color(0xFFA1887F);
  static const Color brown400 = Color(0xFF8D6E63);
  static const Color brown500 = Color(0xFF795548);
  static const Color brown600 = Color(0xFF6D4C41);
  static const Color brown700 = Color(0xFF5D4037);
  static const Color brown800 = Color(0xFF4E342E);
  static const Color brown900 = Color(0xFF3E2723);

  // --- GREY (Sem tons de Accent) ---
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // --- BLUE GREY (Sem tons de Accent) ---
  static const Color blueGrey50 = Color(0xFFECEFF1);
  static const Color blueGrey100 = Color(0xFFCFD8DC);
  static const Color blueGrey200 = Color(0xFFB0BEC5);
  static const Color blueGrey300 = Color(0xFF90A4AE);
  static const Color blueGrey400 = Color(0xFF78909C);
  static const Color blueGrey500 = Color(0xFF607D8B);
  static const Color blueGrey600 = Color(0xFF546E7A);
  static const Color blueGrey700 = Color(0xFF455A64);
  static const Color blueGrey800 = Color(0xFF37474F);
  static const Color blueGrey900 = Color(0xFF263238);

  // --- Tons Utilitários de Opacidade (Black and White) ---
  static const Color black87 = Color(0xDD000000);
  static const Color black54 = Color(0x8A000000);
  static const Color black45 = Color(0x73000000); // Adicionado black45
  static const Color black38 = Color(0x61000000);
  static const Color black26 = Color(0x42000000);
  static const Color black12 = Color(0x1F000000);

  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white54 = Color(0x8AFFFFFF);
  static const Color white38 = Color(0x62FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white24 = Color(0x3DFFFFFF); // Adicionado white24
  static const Color white12 = Color(0x1FFFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);

  static const Color primary = Color(0xFF1E88E5); // Azul Material 3
  static const Color accent = Color(0xFF673AB7); // Roxo para destaques
  static const Color expense = Color(0xFFD32F2F); // Vermelho
  static const Color income = Color(0xFF388E3C); // Verde
  static const Color netWorth = Color(0xFFFFA000); // Âmbar
  static const Color investment = Color(0xFF00ACC1); // Ciano
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color background = Color(0xFFF7F2FA);

  static Color get primaryColor => primaryColor;
  static Color get textColor => textColor;
  static Color get textSecondaryColor => textSecondaryColor;
  static Color get positiveColor => positiveColor;
  static Color get negativeColor => negativeColor;
  //static Color get white => white;
}

/// Contém a paleta completa de cores do Material Design (incluindo todas as tonalidades).
class AppAvaliableColors {
  static const List<Color> availableColors = [
    // --- Cores Principais ---
    Colors.black,
    Colors.white,
    AppColors.red200,
    AppColors.red300,
    //AppColors.red500,
    Colors.red,
    Colors.redAccent,
    AppColors.red900,

    AppColors.pink200,
    AppColors.pink300,
    //AppColors.pink500,
    Colors.pink,
    Colors.pinkAccent,
    AppColors.pink900,

    AppColors.purple200,
    AppColors.purple300,
    //AppColors.purple500,
    Colors.purple,
    Colors.purpleAccent,
    AppColors.purple900,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    AppColors.indigo200,
    AppColors.indigo300,
    //AppColors.indigo500,
    Colors.indigo,
    Colors.indigoAccent,
    AppColors.indigo900,
    AppColors.blue200,
    AppColors.blue300,
    // AppColors.blue500,
    Colors.blue,
    Colors.blueAccent,
    AppColors.blue900,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    AppColors.cyan200,
    AppColors.cyan300,
    //AppColors.cyan500,
    Colors.cyan,
    Colors.cyanAccent,
    AppColors.cyan900,
    AppColors.teal200,
    AppColors.teal300,
    //AppColors.teal500,
    Colors.teal,
    Colors.tealAccent,
    AppColors.teal900,
    AppColors.green200,
    AppColors.green300,
    //AppColors.green500,
    Colors.green,
    Colors.greenAccent,
    AppColors.green900,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    AppColors.lime200,
    AppColors.lime300,
    //AppColors.lime500,
    Colors.lime,
    Colors.limeAccent,
    AppColors.lime900,
    AppColors.teal200,
    AppColors.teal300,
    //AppColors.teal500,
    Colors.teal,
    Colors.tealAccent,
    AppColors.teal900,
    AppColors.yellow200,
    AppColors.yellow300,
    //AppColors.yellow500,
    Colors.yellow,
    Colors.yellowAccent,
    AppColors.yellow900,
    AppColors.amber200,
    AppColors.amber300,
    //AppColors.amber500,
    Colors.amber,
    Colors.amberAccent,
    AppColors.amber900,
    AppColors.orange200,
    AppColors.orange300,
    //AppColors.orange500,
    Colors.orange,
    Colors.orangeAccent,
    AppColors.orange900,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    AppColors.brown200,
    AppColors.brown300,
    //AppColors.brown500,
    Colors.brown,
    AppColors.brown900,
    Colors.blueGrey,
    AppColors.blueGrey200,
    AppColors.blueGrey300,
    AppColors.blueGrey900,
    AppColors.grey200,
    AppColors.grey300,
    Colors.grey,
    AppColors.grey900,
  ];
}

class AppAvaliableIcons {
  static final List<IconData> availableIcons = [
    Icons.money_off,
    Icons.money,
    Icons.shopping_bag,
    Icons.shopping_cart,
    Icons.restaurant,
    Icons.home,
    Icons.work,
    Icons.school,
    Icons.directions_bus,
    Icons.health_and_safety,
    Icons.movie,
    Icons.star,
    Icons.savings,
    Icons.pets,
    Icons.fitness_center,
    Icons.travel_explore,
    Icons.music_note,
    Icons.local_gas_station,
    Icons.phone_iphone,
    Icons.coffee,
  ];

  static Icon getIcon(String name) {
    return Icon(
      availableIcons.firstWhere(
        (icon) => icon.fontFamily == name,
        orElse: () => Icons.help_outline, // Ícone padrão se não encontrado
      ),
    );
  }

  static String? getIconNameFromData(IconData iconData) {
    for (var icon in availableIcons) {
      if (icon.codePoint == iconData.codePoint) {
        return icon.fontFamily; // Retorna o nome da fonte do ícone
      }
    }
    return null; // Retorna null se o ícone não for encontrado
  }

  static String? getIconName(int codePoint) {
    for (var icon in availableIcons) {
      if (icon.codePoint == codePoint) {
        return icon.fontFamily; // Retorna o nome da fonte do ícone
      }
    }
    return null; // Retorna null se o ícone não for encontrado
  }
}
