import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/legacy.dart';

class ControllerBase<T extends Entity<T>>
    extends StateNotifier<CommonResult<List<T?>?>> {
  final ICrudUsecase<T> _usecase;

  ControllerBase(this._usecase)
    : super(CommonResult<List<T>>.success(data: List<T>() = [])) {
    // Carrega categorias ao iniciar
    loadCategories();
  }

  // Carrega categorias ao iniciar
  Future<void> loadCategories() async {
    state = await _usecase.getAll();
  }

  void add(T newT) async {
    await _usecase.add(newT);
    await loadCategories();
  }

  void delete(T tId) async {
    await _usecase.delete(tId);
    await loadCategories();
  }

  void update(T updatedT) async {
    await _usecase.update(updatedT);
    await loadCategories();
  }

  // Métodos de leitura de estado ainda podem existir aqui, se necessário
  T? getById(int id) {
    try {
      return state.data!.firstWhere((c) => c!.id == id);
    } catch (_) {
      return null;
    }
  }
}
