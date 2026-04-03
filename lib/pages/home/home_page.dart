import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/core/authenticated.dart';
import 'package:flutter_crypto_control/pages/home/home_body.dart';
import 'package:flutter_crypto_control/pages/home/home_navigation_bar.dart';
import 'package:flutter_crypto_control/pages/category/category_page.dart';
import 'package:flutter_crypto_control/pages/home/home_navigation_drawer.dart';
import 'package:flutter_crypto_control/pages/home/transaction_page.dart';
import 'package:flutter_crypto_control/pages/subcategory/subcategory_page.dart';
import 'package:flutter_crypto_control/pages/transaction/transaction_page.dart';
import 'package:flutter_crypto_control/widgets/app_consumer_scaffold.dart';
import 'package:flutter_crypto_control/widgets/dialog_widgets.dart';
import 'package:flutter_crypto_control/core/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<_HomePageState> _widgetKey = GlobalKey<_HomePageState>();

  final List<String> titles = const [
    'Dashboard Financeiro',
    'Transações',
    'Investimentos',
    'Patrimônio',
    'SubCategorias',
  ];

  final pages = const [
    HomeBodyScreen(),
    TransactionPageScreen(),
    TransactionsPage(),
    SubCategoryPage(title: "Categoria"),
    CategoryPage(title: "SubCategoria"),
  ];

  String _selectedDrawerItem = AppRoutes.searchUserPage;
  int _currentIndexNavigationBar = 0;

  void _onSelectItem(String index) {
    setState(() {
      _selectedDrawerItem = index;
    });
  }

  void _onTapNavigationBar(int index) {
    setState(() {
      _currentIndexNavigationBar = index;
    });
  }

  Future<void> _logout(BuildContext context) async {
    Authenticated authenticated = Authenticated();
    await authenticated.deleteToken();

    if (!mounted) return;
    Navigator.pop(context);
    Navigator.pushNamed(context, AppRoutes.loginPage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppConsumerScaffold(
        scaffoldKey: _scaffoldKey,
        title: "Home",
        drawer: HomeNavigationDrawer(
          key: _widgetKey,
          selectedIndex: _selectedDrawerItem,
          onSelectItem: _onSelectItem,
          onExit: () {
            showExitDialog(context, onPressed: () => _logout(context));
          },
        ),
        bottomNavigationBar: HomeNavigationBar(
          currentIndex: _currentIndexNavigationBar,
          onTap: (index) => _onTapNavigationBar(index),
        ),
        body: pages[_currentIndexNavigationBar],
      ),
    );
  }
}
