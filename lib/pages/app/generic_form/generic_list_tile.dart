import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/widgets/dynamic_popup_menu_button.dart';

// Definimos um typedef para facilitar a leitura dos builders.
// É uma função que recebe o item (T) e retorna um Widget.
typedef TilePartBuilder<T> = Widget Function(T item);

class GenericListTile<T, A> extends StatelessWidget {
  final T item;

  // Builders para as partes customizáveis do container da linha
  final TilePartBuilder<T>? buildLeading;
  final TilePartBuilder<T> buildTitle; // Título geralmente é obrigatório
  final TilePartBuilder<T>? buildSubtitle;
  // Este builder define o que aparece no trailing ANTES dos três pontos
  final TilePartBuilder<T>? buildTrailingContent;

  // Configuração do menu de ações (que permanece fixo na estrutura)
  final List<MenuEntryBase<A>> menuItems;
  // Callback que devolve a ação selecionada (A) e o item associado (T)
  final Function(A action, T item) onActionSelected;

  // Ação de toque geral no tile (opcional)
  final VoidCallback? onTap;

  const GenericListTile({
    super.key,
    required this.item,
    required this.buildTitle,
    required this.menuItems,
    required this.onActionSelected,
    this.buildLeading,
    this.buildSubtitle,
    this.buildTrailingContent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      // Usa os builders fornecidos para criar as partes visuais
      leading: buildLeading?.call(item),
      title: buildTitle(item),
      subtitle: buildSubtitle?.call(item),

      // AQUI ESTÁ O PULO DO GATO:
      // Mantemos a estrutura fixa do trailing: um Row contendo o conteúdo
      // customizável seguido pelo botão de menu.
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. O conteúdo customizável (ex: o valor monetário)
          if (buildTrailingContent != null)
            // Adicionamos um pequeno espaçamento se houver conteúdo
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: buildTrailingContent!(item),
            ),

          // 2. O menu de ações (sempre presente)
          DynamicPopupMenuButton<A>(
            // Quando uma ação é selecionada, repassamos para quem usou o widget,
            // enviando qual ação foi e qual item foi afetado.
            onSelected: (action) => onActionSelected(action, item),
            items: menuItems,
          ),
        ],
      ),
    );
  }
}
