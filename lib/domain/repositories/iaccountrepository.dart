import 'package:flutter_crypto_control/domain/models/account.dart';

abstract class IAccountRepository {
  Future<List<Account>> getAll();
  Future<List<Account>> getById(int int);
  Future<void> add(Account transaction);
  Future<void> update(Account transaction);
  Future<void> delete(int id);
  Future<void> clear();
}
