import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget {
  int currentIndex;

  final Function(int index) onTap;

  HomeNavigationBar({super.key, required this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        onTap(value);
      },
      items: _itensNavigationBar(),
    );
  }

  NavigationBar _itensNewNavigationBar() {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (int index) {
        onTap(index);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: 'Transações',
        ),
        NavigationDestination(
          icon: Icon(Icons.trending_up_outlined),
          selectedIcon: Icon(Icons.trending_up),
          label: 'Investimentos',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_balance_outlined),
          selectedIcon: Icon(Icons.account_balance),
          label: 'Patrimônio',
        ),
        NavigationDestination(
          icon: Icon(Icons.credit_card_outlined),
          selectedIcon: Icon(Icons.credit_card),
          label: 'Cartão',
        ),
      ],
    );
  }

  List<BottomNavigationBarItem> _itensNavigationBar() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: "Dashboard",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long),
        label: "Transações",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.trending_up),
        label: "Investimentos",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_balance),
        label: "Patrimônio",
      ),
    ];
  }
}
