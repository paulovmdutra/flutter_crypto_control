import 'package:flutter_crypto_control/controller/category_controller.dart';
import 'package:flutter_crypto_control/domain/domain_services/category_usecase.dart';
import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/domain/repositories/icategoryrepository.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/infra/fake/in_memory_transaction_repository.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider global do repositório de transações
final transactionRepositoryProvider = Provider<IRepository<Transaction>>((ref) {
  return InMemoryTransactionRepository();
});

// 1. PROVIDER: Repositório (Camada de Dados)
final categoryRepositoryProvider = FutureProvider<IRepository<Category>>((
  ref,
) async {
  return ServiceLocator.instance.get<IRepository<Category>>();
});

// 2. PROVIDER: Usecase (Camada de Serviço/Negócio)
final categoryUsecaseProvider = FutureProvider<ICrudUsecase<Category>>((
  ref,
) async {
  final repository = await ref.watch(categoryRepositoryProvider.future);
  return CategoryUsecase(repository);
});

final categoryControllerProvider =
    AsyncNotifierProvider<CategoryController, CommonResult<List<Category?>?>>(
      CategoryController.new,
    );

// 4. SELECTOR: Dados filtrados para Receita (Remove a lógica de filtragem da UI)
final incomeCategoriesProvider = FutureProvider<List<Category?>>((ref) async {
  // Observa o estado total do Controller
  final categories = ref.watch(categoryControllerProvider);
  return categories.when(
    data: (list) =>
        list.data!.where((c) => c!.type == TransactionType.income).toList(),
    loading: () => List<Category?>() = [],
    error: (e, _) => List<Category?>() = [],
  );
});

// 5. SELECTOR: Dados filtrados para Despesa (Remove a lógica de filtragem da UI)
final expenseCategoriesProvider = FutureProvider<List<Category?>>((ref) async {
  final categories = ref.watch(categoryControllerProvider);
  return categories.when(
    data: (list) =>
        list.data!.where((c) => c!.type == TransactionType.expense).toList(),
    loading: () => List<Category?>() = [],
    error: (e, _) => List<Category?>() = [],
  );
});
