import 'package:flutter_crypto_control/domain/models/wallet.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';

/// Interface para operações de repositório de Wallet.
abstract class IWalletRepository extends IRepository<Wallet> {
  /// Busca wallets por tipo de conta.
  Future<List<Wallet>> getByType(AccountCategory type);

  /// Busca wallets por moeda.
  Future<List<Wallet>> getByCurrency(String currency);
}