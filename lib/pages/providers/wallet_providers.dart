import 'package:flutter_crypto_control/controller/wallet_controller_riverpod.dart';
import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/domain_services/wallet_usecase.dart';
import 'package:flutter_crypto_control/domain/models/wallet.dart';
import 'package:flutter_crypto_control/domain/repositories/iwallet_repository.dart';
import 'package:flutter_crypto_control/core/exceptions.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletRepositoryProvider = FutureProvider<IWalletRepository>((ref) async {
  try {
    var repository = ServiceLocator.instance.get<IWalletRepository>();
    await repository.init();
    return repository;
  } on Exception catch (e) {
    throw ServiceException(exception: e, message: e.toString());
  }
});

final walletUsecaseProvider = FutureProvider<ICrudUsecase<Wallet>>((ref) async {
  final repository = await ref.watch(walletRepositoryProvider.future);
  return WalletUsecase(repository);
});

final walletControllerProvider =
    AsyncNotifierProvider<WalletController, CommonResult<List<Wallet?>?>>(
      WalletController.new,
    );
