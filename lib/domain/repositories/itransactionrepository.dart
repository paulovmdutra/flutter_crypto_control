import 'package:flutter_crypto_control/domain/models/transaction.dart';

abstract class ITransactionRepository {
  Future<List<Transaction>> getAll();
  Future<List<Transaction>> getByAccount(String accountId);
  Future<void> add(Transaction transaction);
  Future<void> update(Transaction transaction);
  Future<void> delete(String id);
  Future<void> clear();
}
