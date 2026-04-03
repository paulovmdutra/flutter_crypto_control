import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/core/routes.dart';

class MenuItemWidget extends StatelessWidget {
  final String? title;
  final String? rota;
  final Function(String)? onChanged;
  final IconData? icon;
  final bool selected;
  final GestureTapCallback? onTap;

  const MenuItemWidget({
    super.key,
    this.icon,
    this.title,
    this.onChanged,
    this.selected = false,
    this.rota,
    this.onTap,
  });

  GestureTapCallback? _onTap(BuildContext context) {
    return () async {
      // Verifica se a rota está definida na tabela de rotas
      bool isValidRoute = AppRoutes.routes.keys.contains(rota);
      Navigator.pop(context);

      if (isValidRoute) {
        await Navigator.pushNamed(context, rota ?? "");
      }
      if (onTap != null) {
        onTap!();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title ?? ""),
      selected: selected,
      onTap: _onTap(context),
    );
  }
}
