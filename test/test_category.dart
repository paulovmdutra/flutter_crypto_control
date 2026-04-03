import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/category/category_page.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setupWidgets();
  setupRepositories(mode: RepositoryMode.fake);
  setupControllers();
  runApp(const ProviderScope(child: TesteSubcategoryPage()));
}

class TesteSubcategoryPage extends StatefulWidget {
  const TesteSubcategoryPage({Key? key}) : super(key: key);

  @override
  _TesteSubcategoryPageState createState() => _TesteSubcategoryPageState();
}

class _TesteSubcategoryPageState extends State<TesteSubcategoryPage> {
  @override
  Widget build(BuildContext context) {
    // observa o estado atual do tema
    return MaterialApp(home: CategoryPage(), debugShowCheckedModeBanner: false);
  }
}
