import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/widgets/menu_item_widget.dart';
import 'package:flutter_crypto_control/core/routes.dart';

class HomeNavigationDrawer extends StatelessWidget {
  String selectedIndex;
  final Function(String item) onSelectItem;
  final Function() onExit;

  HomeNavigationDrawer({
    super.key,
    required this.onSelectItem,
    required this.onExit,
    this.selectedIndex = "",
  });

  @override
  Widget build(BuildContext context) {
    return _drawer(context);
  }

  Widget _drawer(BuildContext context) {
    // Criando o mapa
    Map<String, Widget> drawerItems = {
      AppRoutes.homePage: DrawerHeader(child: _buildDrawerHeader(context)),
      AppRoutes.subCategoryPage: _buildMenuItem(
        AppRoutes.subCategoryPage,
        "SubCategoria",
        Icons.abc,
      ),
      AppRoutes.categoryPage: _buildMenuItem(
        AppRoutes.categoryPage,
        "Categoria",
        Icons.abc,
      ),
      "sair": MenuItemWidget(
        onTap: () async {
          Future.microtask(() {
            onExit();
          });
        },
        selected: selectedIndex == "sair",
        icon: Icons.abc,
        title: "Sair",
      ),
    };

    return Drawer(
      child: ListView(
        children: drawerItems.entries
            .map(
              (entry) =>
                  Padding(padding: const EdgeInsets.all(0), child: entry.value),
            )
            .toList(),
      ),
    );
  }

  MenuItemWidget _buildMenuItem(String route, String title, IconData icon) {
    return MenuItemWidget(
      selected: selectedIndex == route,
      onTap: () => onSelectItem(route),
      rota: route,
      icon: icon,
      title: title,
    );
  }

  // Widget Builder para o Cabeçalho Customizado
  Widget? _buildDrawerHeader(BuildContext context) {
    // A cor de fundo é definida no container pai (Drawer),
    // mas podemos definir a altura aqui
    return InkWell(
      // Torna o cabeçalho clicável para ir ao perfil
      onTap: () {
        Navigator.pop(context); // Fecha o drawer antes de navegar
        // TODO: Adicionar lógica de navegação (ex: Navigator.pushNamed(context, '/profile'))
        print('Navegar para a tela de Perfil');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 2. Avatar/Imagem de Perfil e Nome de Usuário
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Imagem de Perfil Circular 3D
                Flexible(
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            "assets/images/Profile Image.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /*child: SizedBox(
                    height: 48,
                    width: 48,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Cor de borda de destaque (como o roxo no exemplo)
                        border: Border.all(
                          color: const Color(0xFF7E57C2),
                          width: 3.0,
                        ),
                        // Imagem do Avatar 3D
                        image: const DecorationImage(
                          // Use NetworkImage ou AssetImage dependendo de onde sua imagem está
                          image: NetworkImage(
                            'https://api.dicebear.com/7.x/pixel-art/png?seed=Elon&size=80',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),*/

                // Nome de Usuário / Título
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Elon Musk',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Usuário Padrão',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Status de Verificação
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Ícone de checkmark (você pode usar um ícone personalizado aqui)
              const Icon(Icons.check_circle, color: Colors.lightBlue, size: 16),
              const SizedBox(width: 5),
              const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.lightBlue, // Cor azul vibrante
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
