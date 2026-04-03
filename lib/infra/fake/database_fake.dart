import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/shared/utils/encrypt/encryption_context.dart';

EncryptionContext context = EncryptionContext();

// Gera uma lista de usuários fakes
List<User> gerarUsuariosFakes(int quantidade) {
  final usuarios = <User>[];

  for (int i = 0; i < quantidade; i++) {
    final nome = 'Usuário $i';
    final login = 'usuario$i';
    final senhaOriginal = 'usuario$i';
    final email = 'usuario$i@email.com';
    final telefone = '55519999999$i';
    final status = 'ativo';

    final result = context.encryptPassword(senhaOriginal);

    final usuario = User(
      id: i + 1,
      nome: nome,
      login: login,
      password: result.hash,
      salt: result.salt,
      email: email,
      telefone: telefone,
      status: status,
      data: DateTime.now(),
    );

    usuarios.add(usuario);
  }

  return usuarios;
}

final List<User> usuariosFake = gerarUsuariosFakes(20);
