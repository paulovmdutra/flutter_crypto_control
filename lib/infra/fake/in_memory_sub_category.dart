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
        publicId: "subcat-001",
        name: 'Salário Fixo',
        categoryId: 1,
        category: await getCategory(1), // Busca a categoria pelo ID
        colorValue: AppColors.green300.toARGB32(), // 0xFF81C784
        iconName:
            "attach_money", // Usando o nome do ícone para facilitar a conversão
        currentBalance: 0.0,
      ),
      SubCategory(
        id: 2,
        name: 'Bônus/Comissão',
        categoryId: 1,
        category: await getCategory(1),
        colorValue: AppColors.green500.toARGB32(), // 0xFF4CAF50
        iconName: "star_rate",
        currentBalance: 0.0,
      ),

      // Investimentos (categoryId: 2)
      SubCategory(
        publicId: "subcat-003",
        name: 'Renda Fixa',
        categoryId: 2,
        category: await getCategory(2),
        colorValue: AppColors.blue300.toARGB32(), // 0xFF64B5F6
        iconName: "account_balance",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-004",
        name: 'Ações/FIIs',
        categoryId: 2,
        category: await getCategory(2),
        colorValue: AppColors.blue500.toARGB32(), // 0xFF2196F3
        iconName: "show_chart",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-005",
        name: 'Dividendos',
        categoryId: 2,
        category: await getCategory(2),
        colorValue: AppColors.blue200.toARGB32(), // 0xFF90CAF9
        iconName: "donut_large",
        currentBalance: 0.0,
      ),

      // Extra (categoryId: 3)
      SubCategory(
        publicId: "subcat-006",
        name: 'Freelancer',
        categoryId: 3,
        category: await getCategory(3),
        colorValue: AppColors.amber300.toARGB32(), // 0xFFFFD54F
        iconName: "code",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-007",
        name: 'Presentes/Doações',
        categoryId: 3,
        category: await getCategory(3),
        colorValue: AppColors.amber500.toARGB32(), // 0xFFFFC107
        iconName: "card_giftcard",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-008",
        name: 'Venda de Bens',
        categoryId: 3,
        category: await getCategory(3),
        colorValue: AppColors.amber200.toARGB32(), // 0xFFFFE082
        iconName: "shopping_bag",
        currentBalance: 0.0,
      ),

      // --- Subcategorias de Despesa ---

      // Moradia (categoryId: 4)
      SubCategory(
        publicId: "subcat-009",
        name: 'Aluguel/Hipoteca',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red300
            .toARGB32(), // 0xFFE57373 (Nota: E57373 é Red 300 no Material, mas o valor mais próximo na sua lista era 0xFFEF4C49, então usei o 300 mais parecido)
        iconName: "real_estate_agent",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-010",
        name: 'Contas (Água, Luz, Gás)',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red500.toARGB32(), // 0xFFF44336
        iconName: "receipt_long",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-011",
        name: 'Internet e TV',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red200.toARGB32(), // 0xFFEF9A9A
        iconName: "wifi",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-012",
        name: 'Manutenção',
        categoryId: 4,
        category: await getCategory(4),
        colorValue: AppColors.red900.toARGB32(), // 0xFFC62828
        iconName: "build",
        currentBalance: 0.0,
      ),

      // Alimentação (categoryId: 5)
      SubCategory(
        publicId: "subcat-013",
        name: 'Supermercado',
        categoryId: 5,
        category: await getCategory(5),
        colorValue: AppColors.orange300.toARGB32(), // 0xFFFFB74D
        iconName: "shopping_cart",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-014",
        name: 'Restaurantes/Delivery',
        categoryId: 5,
        category: await getCategory(5),
        colorValue: AppColors.orange500.toARGB32(), // 0xFFFF9800
        iconName: "local_dining",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-015",
        name: 'Café/Lanches',
        categoryId: 5,
        category: await getCategory(5),
        colorValue: AppColors.amber300.toARGB32(), // 0xFFFFD54F
        iconName: "local_cafe",
        currentBalance: 0.0,
      ),

      // Transporte (categoryId: 6)
      SubCategory(
        publicId: "subcat-016",
        name: 'Combustível',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple300.toARGB32(), // 0xFF9575CD
        iconName: "local_gas_station",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-017",
        name: 'Ônibus/Metrô/Trem',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple500.toARGB32(), // 0xFF673AB7
        iconName: "subway",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-018",
        name: 'Aplicativos (Uber/Táxi)',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple200.toARGB32(), // 0xFFB39DDB
        iconName: "local_taxi",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-019",
        name: 'Manutenção do Veículo',
        categoryId: 6,
        category: await getCategory(6),
        colorValue: AppColors.deepPurple800.toARGB32(), // 0xFF4527A0
        iconName: "car_repair",
        currentBalance: 0.0,
      ),

      // Saúde (categoryId: 7)
      SubCategory(
        publicId: "subcat-020",
        name: 'Consultas Médicas',
        categoryId: 7,
        category: await getCategory(7),
        colorValue: AppColors.pink300.toARGB32(), // 0xFFF06292
        iconName: "medication",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-021",
        name: 'Farmácia/Remédios',
        categoryId: 7,
        category: await getCategory(7),
        colorValue: AppColors.pink500.toARGB32(), // 0xFFE91E63
        iconName: "local_pharmacy",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-022",
        name: 'Plano de Saúde',
        categoryId: 7,
        category: await getCategory(7),
        colorValue: AppColors.pink800.toARGB32(), // 0xFFAD1457
        iconName: "health_and_safety",
        currentBalance: 0.0,
      ),

      // Lazer (categoryId: 8)
      SubCategory(
        publicId: "subcat-023",
        name: 'Cinema/Teatro',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan300.toARGB32(), // 0xFF4DD0E1
        iconName: "theaters",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-024",
        name: 'Viagens',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan500.toARGB32(), // 0xFF00BCD4
        iconName: "flight",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-025",
        name: 'Hobby/Esportes',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan200.toARGB32(), // 0xFF80DEEA
        iconName: "sports_soccer",
        currentBalance: 0.0,
      ),
      SubCategory(
        publicId: "subcat-026",
        name: 'Streaming/Assinaturas',
        categoryId: 8,
        category: await getCategory(8),
        colorValue: AppColors.cyan700.toARGB32(), // 0xFF0097A7
        iconName: "subscriptions",
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
