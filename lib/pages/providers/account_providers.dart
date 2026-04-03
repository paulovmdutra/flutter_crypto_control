import 'package:flutter_crypto_control/controller/account_controller.dart';
import 'package:flutter_crypto_control/domain/domain_services/account_usecase.dart';
import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/account.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/infra/repositories/usuario_repository.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';

// 1. PROVIDER: Repositório (Camada de Dados)
final accountRepositoryProvider = Provider<IRepository<Account>>((ref) {
  return ServiceLocator.instance.get<IRepository<Account>>();
});

// 2. PROVIDER: Usecase (Camada de Serviço/Negócio)
final accountUsecaseProvider = Provider<ICrudUsecase<Account>>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return AccountUsecase(repository);
});

// 3. PROVIDER: Controller (Gerenciamento de Estado)
final accountControllerProvider =
    StateNotifierProvider<AccountController, CommonResult<List<Account?>?>>((
      ref,
    ) {
      // O Controller consome a interface do Usecase
      final usecase = ref.watch(accountUsecaseProvider);
      final controller = AccountController(usecase);
      controller.loadCategories(); // Inicia o carregamento
      return controller;
    });
