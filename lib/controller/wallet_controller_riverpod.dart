import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/wallet.dart';
import 'package:flutter_crypto_control/core/exceptions.dart';
import 'package:flutter_crypto_control/pages/providers/wallet_providers.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletController extends AsyncNotifier<CommonResult<List<Wallet?>?>> {
  late final ICrudUsecase<Wallet> _usecase;

  WalletController();

  /// Carrega todas as wallets ao iniciar
  Future<void> loadWallets() async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.getAll();
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Adiciona uma nova wallet
  Future<void> addWallet(Wallet newWallet) async {
    try {
      state = const AsyncLoading();

      final result = await _usecase.add(newWallet);

      if (result.success) {
        final current = state.value?.data ?? [];
        final updatedList = List<Wallet?>.from(current)..add(result.data!);
        final resultList = CommonResult<List<Wallet?>>.success(
          data: updatedList,
        );
        state = AsyncData(resultList);
        return;
      }
      state = AsyncError(result, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Remove uma wallet
  Future<void> deleteWallet(Wallet wallet) async {
    try {
      state = const AsyncLoading();

      final result = await _usecase.delete(wallet);

      if (result.success) {
        final current = state.value?.data ?? [];
        final updatedList = List<Wallet?>.from(current)
          ..removeWhere((w) => w?.id == result.data?.id);
        final resultList = CommonResult<List<Wallet?>>.success(
          data: updatedList,
        );
        state = AsyncData(resultList);
      } else {
        state = AsyncError(result.error!, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Atualiza uma wallet existente
  Future<void> updateWallet(Wallet updatedWallet) async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.update(updatedWallet);

      if (result.success) {
        final current = state.value?.data ?? [];
        final updatedList = current
            .map((w) => w?.id == updatedWallet.id ? updatedWallet : w)
            .toList();
        final updatedResult = CommonResult<List<Wallet?>>(data: updatedList);
        state = AsyncData(updatedResult);
      } else {
        state = AsyncError(result.error!, StackTrace.current);
      }
    } on Exception catch (e, st) {
      state = AsyncError(e, st);
      throw ServiceException(exception: e, message: e.toString());
    }
  }

  /// Busca uma wallet pelo ID
  Wallet? getWalletById(int id) {
    try {
      return state.value!.data!.firstWhere((w) => w!.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Busca wallets por tipo
  List<Wallet> getWalletsByType(AccountCategory type) {
    final wallets = state.value?.data ?? [];
    return wallets.whereType<Wallet>().where((w) => w.type == type).toList();
  }

  /// Busca wallets por moeda
  List<Wallet> getWalletsByCurrency(String currency) {
    final wallets = state.value?.data ?? [];
    return wallets
        .whereType<Wallet>()
        .where((w) => w.currency.toLowerCase() == currency.toLowerCase())
        .toList();
  }

  @override
  Future<CommonResult<List<Wallet?>?>> build() async {
    final usecaseAsync = await ref.watch(walletUsecaseProvider.future);
    _usecase = usecaseAsync;
    final result = await _usecase.getAll();
    return result;
  }
}
