import 'package:flutter_crypto_control/controller/controllers.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/domain/models/usuario.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/exceptions.dart';
import 'package:flutter_crypto_control/infra/api/api_repository.dart';
import 'package:flutter_crypto_control/infra/fake/fake_usuario_repository.dart';
import 'package:flutter_crypto_control/infra/fake/in_memory_category_repository.dart';
import 'package:flutter_crypto_control/infra/fake/in_memory_sub_category.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/riverpod_factory.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/pages/subcategory/riverpod/riverpod_factory.dart';

/// A classe `ServiceLocator` fornece um mecanismo centralizado para
///  registrar e recuperar serviços em uma aplicação.
///
/// Exemplo de uso da classe ServiceLocator:
///
/// ```dart
/// void main() {
///   // Criando uma instância do ServiceLocator
///   var locator = ServiceLocator();
///
///   // Registrando um serviço
///   locator.registerService("logger", Logger());
///
///   // Obtendo o serviço
///   var logger = locator.getService("logger");
///   logger.log("Hello, world!");
/// }
/// ```
///
/// Neste exemplo, criamos uma instância do `ServiceLocator`,
/// registramos um serviço com a chave "logger" e, em seguida,
/// recuperamos esse serviço usando `getService`. Finalmente,
/// utilizamos o serviço obtido para fazer um log de uma mensagem.
/*class ServiceLocator {
  // Instância única da classe (privada).
  static final ServiceLocator _instance = ServiceLocator._internal();

  // Construtor privado para impedir múltiplas instâncias.
  ServiceLocator._internal();

  // Getter público para acessar a instância única.
  static ServiceLocator get instance => _instance;

  /// Um mapa que mantém os serviços registrados, onde a chave é uma
  /// String representando o nome do serviço e o valor é o próprio serviço.
  final Map<String, dynamic> _singletons = {};
  final Map<String, Function> _factories = {};

  /// Registra um serviço com a chave especificada.
  ///
  /// O parâmetro [key] é a chave única que identifica o serviço.
  ///
  /// O parâmetro [service] é o próprio serviço a ser registrado.
  void registerSingleton<T>(String key, T Function() service) {
    if (_factories.containsKey(key)) {
      throw ServiceException(
        message: "Serviço com chave $key já foi registrado.",
      );
    }

    _factories[key] = () {
      if (!_singletons.containsKey(key)) {
        _singletons[key] = service();
      }
      return _singletons[key];
    };
  }

  void registerFactory<T>(String key, T Function() service) {
    if (_factories.containsKey(key)) {
      throw ServiceException(
        message: "Serviço com chave '$key' já foi registrado.",
      );
    }
    _factories[key] = service;
  }

  /// Recupera o serviço associado à chave especificada.
  ///
  /// Retorna o serviço correspondente à chave [key] fornecida,
  /// ou [null] se nenhum serviço estiver registrado com essa chave.
  dynamic getService(String key) {
    final builder = _factories[key];
    if (builder == null) {
      throw ServiceException(
        message:
            "Serviço $key não registrado! Verifique a configuração do ServiceLocator.",
      );
    }
    return builder();
  }

  /// Remove o tipo T do container (tanto singleton quanto factory)
  void unregister(String key) {
    _factories.remove(key);
    _singletons.remove(key);
  }

  ///Verifica se o serviço foi registrado
  bool isRegistered(String key) => _factories.containsKey(key);
}*/

class ServiceLocator {
  // Singleton boilerplate
  static final ServiceLocator _instance = ServiceLocator._internal();
  ServiceLocator._internal();
  static ServiceLocator get instance => _instance;

  // Mudança 1: A chave agora é 'Type' em vez de 'String'
  final Map<Type, dynamic> _singletons = {};
  final Map<Type, Function> _factories = {};

  /// Registra um Singleton.
  /// Exemplo: registerSingleton<UsuarioRepository>(() => ApiUsuarioRepository());
  void registerSingleton<T extends Object>(T Function() factoryFunc) {
    // Verificamos se T já está registrado
    if (_factories.containsKey(T)) {
      // Opcional: Pode lançar erro ou apenas ignorar/sobrescrever
      throw ServiceException(message: "Tipo '$T' já foi registrado.");
    }

    // Guardamos a função construtora
    _factories[T] = () {
      // Lazy Loading: Só cria a instância se ela ainda não existir
      if (!_singletons.containsKey(T)) {
        _singletons[T] = factoryFunc();
      }
      return _singletons[T];
    };
  }

  /// Registra uma Factory (cria um novo objeto a cada chamada).
  /// Exemplo: registerFactory<UsuarioController>(() => UsuarioController());
  void registerFactory<T extends Object>(T Function() factoryFunc) {
    if (_factories.containsKey(T)) {
      throw ServiceException(message: "Tipo '$T' já foi registrado.");
    }
    _factories[T] = factoryFunc;
  }

  /// Recupera o serviço.
  /// Exemplo: final repo = locator.get<UsuarioRepository>();
  /// Não precisa de CAST! O retorno já é T.
  T get<T extends Object>() {
    final builder = _factories[T];

    if (builder == null) {
      throw ServiceException(
        message:
            "Serviço do tipo '$T' não encontrado! Você esqueceu de registrar?",
      );
    }

    // Chama o builder e garante que o retorno é do tipo T
    return builder() as T;
  }

  /// Remove o registro (útil para testes/reset)
  void unregister<T extends Object>() {
    _factories.remove(T);
    _singletons.remove(T);
  }

  /// Helper para resetar tudo (útil em tearDown de testes)
  void reset() {
    _factories.clear();
    _singletons.clear();
  }
}

/// Contém as chaves usadas para registrar e recuperar serviços no `ServiceLocator`.
enum ServiceKeys {
  /// Chave de identificação para o serviço relacionado ao repositório de usuários.
  repositoryUsuario, // = 'repositoryUsuario';
  repositoryEstado, // = 'repositoryEstado';
  repositoryCidade, // = 'repositoryCidade';
  repositoryCliente, // = 'repositoryCliente';
  repositoryCategory, // = 'repositoryCliente';
  repositorySubCategory, // = 'repositoryCliente';
  repositoryAccount, // = 'repositoryCliente';
  controllerEstado, // = "controllerEstado";
  controllerUser, // = "controllerUser";
  controllerCidade, // = "controllerCidade";
  controllerCliente, // = "controllerCliente";
}

/// Enum que define os modos disponíveis para configuração de repositórios.
enum RepositoryMode {
  /// Utiliza repositórios fake/mock, geralmente usados para testes ou desenvolvimento inicial.
  mock,

  /// Utiliza repositórios que fazem chamadas para uma API real.
  api,

  /// Utiliza repositórios locais, como armazenamento SQLite ou arquivos.
  local,
}

/// Inicializa os repositórios usando uma implementação que consome uma API real.
///
/// Registra os repositórios necessários no `ServiceLocator` usando o modo de produção.
void initApiRepositories() {
  // Registrando a implementação concreta na Interface (igual C# services.AddSingleton<IUser, User>())
  ServiceLocator.instance.registerSingleton<IRepository<Category>>(
    () => ApiRepository<Category>(
      endPointBase: "/api/category",
      fromJson: Category.fromMap,
    ),
  );

  // Registrando a implementação concreta na Interface (igual C# services.AddSingleton<IUser, User>())
  ServiceLocator.instance.registerSingleton<IRepository<SubCategory>>(
    () => ApiRepository<SubCategory>(
      endPointBase: "/api/subcategory",
      fromJson: SubCategory.fromMap,
    ),
  );
}

/// Inicializa os repositórios fake (mocks) para simulação ou testes.
///
/// Ideal para uso em ambientes de desenvolvimento ou durante testes unitários.
void initFakeRepositories() {
  ServiceLocator.instance.registerSingleton<IRepository<Usuario>>(
    () => FakeUsuarioRepository(),
  );
  ServiceLocator.instance.registerSingleton<IRepository<Category>>(
    () => InMemoryCategoryRepository(),
  );
  ServiceLocator.instance.registerSingleton<IRepository<SubCategory>>(
    () => InMemorySubCategoryRepository(),
  );

  /*ServiceLocator.instance.registerSingleton(
    ServiceKeys.repositoryUsuario.name,
    () => FakeUsuarioRepository(),
  );
  ServiceLocator.instance.registerSingleton(
    ServiceKeys.repositoryCategory.name,
    () => InMemoryCategoryRepository(),
  );
  ServiceLocator.instance.registerSingleton(
    ServiceKeys.repositorySubCategory.name,
    () => InMemorySubCategoryRepository(),
  );*/
}

void setupControllers() {
  /*UsuarioRepository usuarioRepository = ServiceLocator.instance.getService(
    ServiceKeys.repositoryUsuario.name,
  );*/
  /*ServiceLocator.instance.registerFactory(
    ServiceKeys.controllerUser.name,
    () => UsuarioController(),
  );*/

  ServiceLocator.instance.registerFactory<UsuarioController>(
    () => UsuarioController(),
  );
}

/// Inicializa os repositórios com base no modo especificado.
///
/// Permite configurar o ambiente de execução para usar diferentes
/// tipos de repositórios (fake, api, local).
///
/// Exemplo de uso:
/// ```dart
/// setupRepositories(mode: RepositoryMode.fake);
/// ```
///
/// [mode] O tipo de repositório a ser utilizado.
void setupRepositories({required RepositoryMode mode}) {
  switch (mode) {
    case RepositoryMode.mock:
      initFakeRepositories();
      return;
    case RepositoryMode.api:
      initApiRepositories();
      return;
    case RepositoryMode.local:
      // No futuro, implementar initLocalRepositories();
      return;
  }
}

void setupWidgets() {
  // Registra a implementação do Riverpod sob a interface ISubCategoryFactory
  ServiceLocator.instance.registerFactory<ISubCategoryFactory>(
    () => RiverpodSubCategoryFactory(),
  );

  // Registra a implementação do Riverpod sob a interface ISubCategoryFactory
  ServiceLocator.instance.registerFactory<ICategoryFactory>(
    () => RiverpodCategoryFactory(),
  );
}

// Define a assinatura da função construtora
/*typedef SubCategoryFormBuilder = Widget Function({SubCategory? subcategory});

class AppWidgetFactory {
  // A variável estática que guardará a implementação
  static SubCategoryFormBuilder? _subCategoryFormBuilder;

  // Método para REGISTRAR qual adapter vamos usar (chamado no main)
  static void registerSubCategoryForm(SubCategoryFormBuilder builder) {
    _subCategoryFormBuilder = builder;
  }

  // Método para USAR o adapter (chamado na Page)
  static Widget createSubCategoryForm({SubCategory? subcategory}) {
    if (_subCategoryFormBuilder == null) {
      throw Exception(
        "Nenhum Adapter de SubCategoria foi registrado no AppWidgetFactory!",
      );
    }
    return _subCategoryFormBuilder!(subcategory: subcategory);
  }
}*/
