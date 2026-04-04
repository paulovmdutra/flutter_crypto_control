import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/infra/fake/fake_repository.dart';

class InMemoryCategoryRepository extends FakeRepository<Category> {
  InMemoryCategoryRepository() {
    fakeData.addAll([
      // Receitas
      Category(
        id: 1,
        publicId: '1',
        name: 'Salário',
        type: TransactionType.income,
        colorValue: 0xFF4CAF50,
        iconName: "work",
      ),
      Category(
        id: 2,
        publicId: '2',
        name: 'Investimentos',
        type: TransactionType.income,
        colorValue: 0xFF2196F3,
        iconName: "trending_up",
      ),
      Category(
        id: 3,
        publicId: '3',
        name: 'Extra',
        type: TransactionType.income,
        colorValue: 0xFFFFC107,
        iconName: "star",
      ),

      // Despesas
      Category(
        id: 4,
        publicId: '4',
        name: 'Moradia',
        type: TransactionType.expense,
        colorValue: 0xFFF44336,
        iconName: "home",
      ),
      Category(
        id: 5,
        publicId: '5',
        name: 'Alimentação',
        type: TransactionType.expense,
        colorValue: 0xFFFF9800,
        iconName: "restaurant",
      ),
      Category(
        id: 6,
        publicId: '6',
        name: 'Transporte',
        type: TransactionType.expense,
        colorValue: 0xFF673AB7,
        iconName: "directions_bus",
      ),
      Category(
        id: 7,
        publicId: '7',
        name: 'Saúde',
        type: TransactionType.expense,
        colorValue: 0xFFE91E63,
        iconName: "health_and_safety",
      ),
      Category(
        id: 8,
        publicId: '8',
        name: 'Lazer',
        type: TransactionType.expense,
        colorValue: 0xFF00BCD4,
        iconName: "movie",
      ),
    ]);
  }
}
