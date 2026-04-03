import 'package:flutter/material.dart';

// 1. Classe Base Abstrata
// Define qualquer tipo de entrada que possa existir no nosso menu dinâmico.
abstract class MenuEntryBase<T> {}

// 2. Entrada para item normal (Ação com ícone e texto)
class MenuActionItem<T> extends MenuEntryBase<T> {
  final String label;
  final IconData icon;
  final T value;
  // Adicionamos isto para facilitar estilizar o botão de "Deletar" em vermelho
  final bool isDestructive;

  MenuActionItem({
    required this.label,
    required this.icon,
    required this.value,
    this.isDestructive = false, // Padrão é falso (cor normal)
  });
}

// 3. Entrada para separador
// Não precisa de dados, sua presença na lista já indica o que ele é.
class MenuSeparatorItem<T> extends MenuEntryBase<T> {}

class DynamicPopupMenuButton<T> extends StatelessWidget {
  // A lista agora aceita a classe base, permitindo ações e separadores misturados
  final List<MenuEntryBase<T>> items;
  final PopupMenuItemSelected<T> onSelected;
  final Widget? icon;

  const DynamicPopupMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      icon: icon,
      // O itemBuilder deve retornar uma lista de PopupMenuEntry
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<T>> menuWidgets = [];

        for (final entry in items) {
          // VERIFICAÇÃO DE TIPO: É um separador?
          if (entry is MenuSeparatorItem<T>) {
            menuWidgets.add(const PopupMenuDivider());
          }
          // VERIFICAÇÃO DE TIPO: É um item de ação normal?
          else if (entry is MenuActionItem<T>) {
            // Define a cor baseada se é destrutivo ou não
            final Color itemColor = entry.isDestructive
                ? Colors.red
                : Colors.grey[700]!;

            menuWidgets.add(
              PopupMenuItem<T>(
                value: entry.value,
                child: Row(
                  children: [
                    Icon(entry.icon, size: 20, color: itemColor),
                    const SizedBox(width: 10),
                    Text(
                      entry.label,
                      style: TextStyle(
                        color: itemColor,
                      ), // Aplica a cor também ao texto
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return menuWidgets;
      },
    );
  }
}
