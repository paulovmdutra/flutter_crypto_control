import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/infra/fake/fake_repository.dart';
import 'package:flutter_crypto_control/infra/fake/in_memory_category_repository.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class InMemorySubCategoryRepository extends FakeRepository<SubCategory> {
  InMemorySubCategoryRepository();

  var categoryRepository = InMemoryCategoryRepository();

  // Funções auxiliares para buscar no mapa
  Future<Category?> getCategory(int id) async {
    // 1. Buscar TODAS as Categorias e armazenar em um Map para acesso rápido (Otimização do JOIN)
    // Assumindo que categoryRepository.getAllAsync() retorna todas as 8 categorias.
    final categoriesResult = await categoryRepository.getAllAsync();

    if (categoriesResult.data == null || categoriesResult.data!.isEmpty) {
      // Tratar caso as categorias não tenham sido carregadas.
      print('Erro: Nenhuma categoria carregada.');
      return null;
    }

    // Cria um mapa para buscar categorias por ID rapidamente: {id: Category_object}
    final categoriesMap = {
      for (var cat in categoriesResult.data!) cat!.id: cat,
    };
    final cat = categoriesMap[id];
    if (cat == null) {
      throw Exception('Categoria com ID $id não encontrada.');
    }
    return cat;
  }
  // Assumindo que você tem as classes Category e SubCategory,
  // TransactionType e a classe InMemoryCategoryRepository
  // disponíveis no seu escopo.

  Future<void> init() async {
    // --- 2. Inserção das Subcategorias ---
    // Salário (categoryId: 1)
    fakeData.addAll([
      SubCategory(
        id: 1,
        name: 'Salário Fixo',
        categoryId: 1,
        category: await getCategory(1), // Busca a categoria pelo ID
        colorValue: AppColors.green300.toARGB32(), // 0xFF81C784
        iconCodePoint: Icons.attach_money,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 2,
        name: 'Bônus/Comissão',
        categoryId: 1,
        category: await getCategory(1),
        colorValue: AppColors.green500.toARGB32(), // 0xFF4CAF50
        iconCodePoint: Icons.star_rate,
        currentBalance: 0.0,
      ),

      // Investimentos (categoryId: 2)
      SubCategory(
        id: 3,
        name: 'Renda Fixa',
        categoryId: 2,
        category: await getCategory(2),
        colorValue: AppColors.blue300.toARGB32(), // 0xFF64B5F6
        iconCodePoint: Icons.account_balance,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 4,
        name: 'Ações/FIIs',
        categoryId: 2,
        category: await getCategory(2),
        colorValue: AppColors.blue500.toARGB32(), // 0xFF2196F3
        iconCodePoint: Icons.show_chart,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 5,
        name: 'Dividendos',
        categoryId: 2,
        category: await getCategory(2),
        colorValue: AppColors.blue200.toARGB32(), // 0xFF90CAF9
        iconCodePoint: Icons.donut_large,
        currentBalance: 0.0,
      ),

      // Extra (categoryId: 3)
      SubCategory(
        id: 6,
        name: 'Freelancer',
        categoryId: 3,
        category: await getCategory(3),
        colorValue: AppColors.amber300.toARGB32(), // 0xFFFFD54F
        iconCodePoint: Icons.code,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 7,
        name: 'Presentes/Doações',
        categoryId: 3,
        category: await getCategory(3),
        colorValue: AppColors.amber500.toARGB32(), // 0xFFFFC107
        iconCodePoint: Icons.card_giftcard,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 8,
        name: 'Venda de Bens',
        categoryId: 3,
        category: await getCategory(3),
        colorValue: AppColors.amber200.toARGB32(), // 0xFFFFE082
        iconCodePoint: Icons.shopping_bag,
        currentBalance: 0.0,
      ),

      // --- Subcategorias de Despesa ---

      // Moradia (categoryId: 4)
      SubCategory(
        id: 9,
        name: 'Aluguel/Hipoteca',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red300
            .toARGB32(), // 0xFFE57373 (Nota: E57373 é Red 300 no Material, mas o valor mais próximo na sua lista era 0xFFEF4C49, então usei o 300 mais parecido)
        iconCodePoint: Icons.real_estate_agent,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 10,
        name: 'Contas (Água, Luz, Gás)',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red500.toARGB32(), // 0xFFF44336
        iconCodePoint: Icons.receipt_long,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 11,
        name: 'Internet e TV',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red200.toARGB32(), // 0xFFEF9A9A
        iconCodePoint: Icons.wifi,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 12,
        name: 'Manutenção',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red900.toARGB32(), // 0xFFC62828
        iconCodePoint: Icons.build,
        currentBalance: 0.0,
      ),

      // Alimentação (categoryId: 5)
      SubCategory(
        id: 13,
        name: 'Supermercado',
        categoryId: 5,
        category: await getCategory(5),
        colorValue: AppColors.orange300.toARGB32(), // 0xFFFFB74D
        iconCodePoint: Icons.shopping_cart,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 14,
        name: 'Restaurantes/Delivery',
        categoryId: 5,
        category: await getCategory(5),
        colorValue: AppColors.orange500.toARGB32(), // 0xFFFF9800
        iconCodePoint: Icons.local_dining,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 15,
        name: 'Café/Lanches',
        categoryId: 5,
        category: await getCategory(5),
        colorValue: AppColors.amber300.toARGB32(), // 0xFFFFD54F
        iconCodePoint: Icons.local_cafe,
        currentBalance: 0.0,
      ),

      // Transporte (categoryId: 6)
      SubCategory(
        id: 16,
        name: 'Combustível',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple300.toARGB32(), // 0xFF9575CD
        iconCodePoint: Icons.local_gas_station,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 17,
        name: 'Ônibus/Metrô/Trem',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple500.toARGB32(), // 0xFF673AB7
        iconCodePoint: Icons.subway,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 18,
        name: 'Aplicativos (Uber/Táxi)',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple200.toARGB32(), // 0xFFB39DDB
        iconCodePoint: Icons.local_taxi,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 19,
        name: 'Manutenção do Veículo',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple800.toARGB32(), // 0xFF4527A0
        iconCodePoint: Icons.car_repair,
        currentBalance: 0.0,
      ),

      // Saúde (categoryId: 7)
      SubCategory(
        id: 20,
        name: 'Consultas Médicas',
        categoryId: 7,
        category: await getCategory(7),
        colorValue: AppColors.pink300.toARGB32(), // 0xFFF06292
        iconCodePoint: Icons.medication,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 702,
        name: 'Farmácia/Remédios',
        categoryId: 7,
        category: await getCategory(7),
        colorValue: AppColors.pink500.toARGB32(), // 0xFFE91E63
        iconCodePoint: Icons.local_pharmacy,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 703,
        name: 'Plano de Saúde',
        categoryId: 7,
        category: await getCategory(7),
        colorValue: AppColors.pink800.toARGB32(), // 0xFFAD1457
        iconCodePoint: Icons.health_and_safety,
        currentBalance: 0.0,
      ),

      // Lazer (categoryId: 8)
      SubCategory(
        id: 801,
        name: 'Cinema/Teatro',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan300.toARGB32(), // 0xFF4DD0E1
        iconCodePoint: Icons.theaters,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 802,
        name: 'Viagens',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan500.toARGB32(), // 0xFF00BCD4
        iconCodePoint: Icons.flight,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 803,
        name: 'Hobby/Esportes',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan200.toARGB32(), // 0xFF80DEEA
        iconCodePoint: Icons.sports_soccer,
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 804,
        name: 'Streaming/Assinaturas',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan700.toARGB32(), // 0xFF0097A7
        iconCodePoint: Icons.subscriptions,
        currentBalance: 0.0,
      ),
    ]);
  }
  /*
  @override
  Future<CommonResult<List<SubCategory?>>> getAllAsync() async {
    final List<SubCategory?> rawSubcategories = fakeData;
    final categories = await categoryRepository.getAllAsync();
    final List<SubCategory?> completedSubcategories =
        joinCategoriesWithSubcategories(
          categories: categories.data!,
          subcategories: rawSubcategories,
        );

    await Future.delayed(const Duration(milliseconds: 500));
    return CommonResult.success(
      data: List<SubCategory?>.from(completedSubcategories),
    );
  }*/

  /// Realiza o "Inner Join" entre categorias e subcategorias.
  ///
  /// Associa o objeto Category completo em cada SubCategory baseando-se no categoryId.
  /// Apenas subcategorias que têm uma Category correspondente são incluídas no resultado (Inner Join).
  List<SubCategory?> joinCategoriesWithSubcategories({
    required List<Category?> categories,
    required List<SubCategory?> subcategories,
  }) {
    // 1. Otimização: Criar um Map de busca rápida {categoryId: Category_object}
    final categoriesMap = {
      for (var category in categories) category!.id: category,
    };

    // 2. Aplicar o Join, mapeando a lista de subcategorias
    final List<SubCategory> joinedList = subcategories
        // INNER JOIN: Filtra apenas as subcategorias onde a categoria existe no mapa.
        .where((sub) => categoriesMap.containsKey(sub!.categoryId))
        // Mapeia para uma nova lista de SubCategory com a propriedade 'category' preenchida.
        .map((sub) {
          final category = categoriesMap[sub!.categoryId]!;

          // Retorna uma nova instância de SubCategory (imutabilidade) com a Category associada.
          return sub.copyWith(category: category);
        })
        .toList();

    return joinedList;
  }
}
