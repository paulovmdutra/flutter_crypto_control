import 'package:flutter_crypto_control/domain/models/wallet.dart';
import 'package:flutter_crypto_control/domain/repositories/iwallet_repository.dart';
import 'package:flutter_crypto_control/infra/fake/fake_repository.dart';

class InMemoryWalletRepository extends FakeRepository<Wallet>
    implements IWalletRepository {
  InMemoryWalletRepository() {
    fakeData.addAll([
      Wallet(
        id: 1,
        publicId: 'wallet-001',
        name: 'Binance Principal',
        assetId: 1,
        currency: 'USDT',
        balance: 1500.00,
        type: AccountCategory.exchange,
        apiKey: 'api-key-001',
        secret_key: 'secret-key-001',
        walletAddress: '0x1234567890abcdef',
      ),
      Wallet(
        id: 2,
        publicId: 'wallet-002',
        name: 'Coinbase Pro',
        assetId: 2,
        currency: 'BTC',
        balance: 0.05,
        type: AccountCategory.exchange,
        apiKey: 'api-key-002',
        secret_key: 'secret-key-002',
        walletAddress: '0xabcdef1234567890',
      ),
      Wallet(
        id: 3,
        publicId: 'wallet-003',
        name: 'MetaMask',
        assetId: 3,
        currency: 'ETH',
        balance: 2.5,
        type: AccountCategory.hotWallet,
        apiKey: '',
        secret_key: '',
        walletAddress: '0x9876543210fedcba',
      ),
      Wallet(
        id: 4,
        publicId: 'wallet-004',
        name: 'Ledger Nano X',
        assetId: 4,
        currency: 'BTC',
        balance: 0.1,
        type: AccountCategory.coldWallet,
        apiKey: '',
        secret_key: '',
        walletAddress: '0xfedcba0987654321',
      ),
      Wallet(
        id: 5,
        publicId: 'wallet-005',
        name: 'Conta Corrente Banco',
        assetId: 5,
        currency: 'BRL',
        balance: 5000.00,
        type: AccountCategory.checkingAccount,
        apiKey: '',
        secret_key: '',
        walletAddress: '',
      ),
    ]);
  }

  @override
  Future<List<Wallet>> getByType(AccountCategory type) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return fakeData.whereType<Wallet>().where((w) => w.type == type).toList();
  }

  @override
  Future<List<Wallet>> getByCurrency(String currency) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return fakeData
        .whereType<Wallet>()
        .where((w) => w.currency.toLowerCase() == currency.toLowerCase())
        .toList();
  }
}