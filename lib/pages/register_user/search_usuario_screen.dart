// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/pages/app/generic_search_screen.dart';
import 'package:flutter_crypto_control/core/routes.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/utils/util.dart';

class SearchUsuarioScreen extends StatefulWidget {
  static const String routeName = "/search_user_screen";

  const SearchUsuarioScreen({super.key});

  @override
  State<SearchUsuarioScreen> createState() => SearchUsuarioScreenState();
}

class SearchUsuarioScreenState extends State<SearchUsuarioScreen> {
  final UserController controller = UserController();
  // ServiceLocator.instance.getService(ServiceKeys.controllerUser.name);

  @override
  Widget build(BuildContext context) {
    return GenericSearchScreen<User>(
      title: "Usuário",
      onLoadItems: () async {
        final result = await controller.findAll();
        if (!result.success) {
          throw Exception(result.message);
        }
        return result.data!;
      },
      onTapItem: (usuario) async {
        final bundle = Bundle()..put(Argument.entity, usuario);
        await Navigator.pushNamed(
          context,
          AppRoutes.registerUserFormPage,
          arguments: bundle,
        );
        setState(() {});
      },
      onDeleteItem: (usuario) async {
        controller.usuarioViewModel.fromEntity(usuario);
        return await controller.delete();
      },
      searchableFields: {
        "nome": (c) => c.nome ?? '',
        "login": (c) => c.login ?? '',
      },
      titleBuilder: (usuario) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            usuario.nome!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(usuario.login!, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
