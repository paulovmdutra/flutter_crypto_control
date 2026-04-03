import 'package:flutter_crypto_control/controller/subCategory_controller.dart';
import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/domain_services/subCategory_usecase.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/exceptions.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subCategoryRepositoryProvider = FutureProvider<IRepository<SubCategory>>((
  ref,
) async {
  try {
    var repository = ServiceLocator.instance.get<IRepository<SubCategory>>();
    await repository.init();
    return repository;
  } on Exception catch (e) {
    throw ServiceException(exception: e, message: e.toString());
  }
});

final subCategoryUsecaseProvider = FutureProvider<ICrudUsecase<SubCategory>>((
  ref,
) async {
  final repository = await ref.watch(subCategoryRepositoryProvider.future);
  return SubCategoryUsecase(repository);
});

final subCategoryControllerProvider =
    AsyncNotifierProvider<
      SubCategoryController,
      CommonResult<List<SubCategory?>?>
    >(SubCategoryController.new);
