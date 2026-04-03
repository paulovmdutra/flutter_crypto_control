// Implementação do Repositório de Contas em Memória
import 'package:flutter_crypto_control/domain/models/account.dart';
import 'package:flutter_crypto_control/domain/repositories/iaccountrepository.dart';

class InMemoryAccountRepository implements IAccountRepository {
  final List<Account> _accounts = [
    Account(
      id: 1,
      publicId: '',
      name: 'Conta Corrente Principal',
      currentBalance: 8500.00,
      currency: "BRL",
    ),
    Account(
      id: 2,
      publicId: '',
      name: 'Carteira/Dinheiro',
      currentBalance: 150.75,
      currency: "BRL",
    ),
    Account(
      id: 3,
      publicId: '',
      name: 'Investimentos XP',
      currentBalance: 15430.50,
      currency: "BRL",
    ),
    Account(
      id: 4,
      publicId: '',
      name: 'Conta Poupança Emergência',
      currentBalance: 12000.00,
      currency: "BRL",
    ),
  ];

  @override
  Future<List<Account>> getAll() async {
    // Simula latência de rede
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_accounts);
  }

  @override
  Future<void> add(Account account) async {
    final newId = _accounts.length + 1;
    final accountWithId = Account(
      id: newId,
      publicId: account.publicId,
      name: account.name,
      currentBalance: account.currentBalance,
      currency: "BRL",
    );
    _accounts.add(accountWithId);
    await Future.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> update(Account account) async {
    final index = _accounts.indexWhere((a) => a.id == account.id);
    if (index != -1) {
      _accounts[index] = account;
    }
    await Future.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> delete(int id) async {
    _accounts.removeWhere((a) => a.id == id);
    await Future.delayed(const Duration(milliseconds: 50));
  }

  @override
  Future<void> clear() async {
    _accounts.clear();
  }

  @override
  Future<List<Account>> getById(int int) async {
    return _accounts.where((a) => a.id == int).toList();
  }
}

/// Provider global do repositório de contas
/*final accountRepositoryProvider = Provider<IAccountRepository>((ref) {
  return InMemoryAccountRepository();
});*/
