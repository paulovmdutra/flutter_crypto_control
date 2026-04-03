import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';

abstract class ICategoryRepository{
  Future<List<Category>> getAll();
  Future<List<Category>> getByAccount(String accountId);
  Future<void> add(Category transaction);
  Future<void> update(Category transaction);
  Future<void> delete(int id);
  Future<void> clear();
}
