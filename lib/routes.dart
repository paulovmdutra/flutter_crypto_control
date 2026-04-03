import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/category/category_page.dart';
import 'package:flutter_crypto_control/pages/home/home_page.dart';
import 'package:flutter_crypto_control/pages/login/login_screen.dart';
import 'package:flutter_crypto_control/pages/subcategory/subcategory_page.dart';
import 'package:flutter_crypto_control/widgets/app_scaffold.dart';

class Routes {
  static String homePage = "/";
  static const String searchUserPage = '/search_user_page';
  static const String registerUserFormPage = '/register_user_form_page';
  static const String loginPage = '/login_page';
  static const String clientePage = '/cliente_page';
  static const String cidadePage = '/cidade_page';
  static const String estadoPage = '/estado_page';
  static const String subCategoryPage = '/subcategory_page';
  static const String categoryPage = '/category_page';
  static const String searchEstadoPage = "/search_estado_page";
  static const String searchClientePage = "/search_cliente_page";
  static const String registerWaller = "/register_wallets";
  static const String changePasswordFormPage = "/change_password_form_page";

  static Map<String, WidgetBuilder> routes = {
    homePage: (context) => const HomePage(),
    loginPage: (context) => const LoginScreen(),
    categoryPage: (context) => CategoryPage(title: "Categoria"),
    subCategoryPage: (context) => AppScaffold(
      title: "SubCategoria",
      body: SubCategoryPage(title: "SubCategoria"),
    ),
  };
}
