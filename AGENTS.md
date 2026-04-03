# Flutter Crypto Control - Estratégia de Desenvolvimento

## Visão Geral do Projeto

Aplicação Flutter para controle financeiro e criptomoedas, estruturada com arquitetura limpa e separação de responsabilidades.

## Tecnologias

- Flutter
- Riverpod
- HTTP
- SharedPreferences
- fl_chart

## Executar

```
flutter pub get
flutter run
```

## Arquitetura

O projeto segue uma arquitetura em camadas inspirada em Clean Architecture e MVC:

### Camadas

```
lib/
├── controller/          # Controladores (lógica de aplicação)
├── domain/              # Camada de domínio (regras de negócio)
│   ├── models/          # Entidades e modelos
│   ├── repositories/    # Interfaces dos repositórios
│   ├── domain_services/ # Casos de uso e serviços de domínio
│   └── value_objects/   # Objetos de valor
├── application/         # Camada de aplicação
│   ├── dtos/            # Data Transfer Objects
│   └── usecase/         # Casos de uso
├── infra/               # Infraestrutura e implementação
│   ├── api/             # Repositórios que consomem API
│   ├── fake/            # Repositórios mock para testes
│   └── repositories/    # Implementações de repositórios
├── pages/               # Telas e UI
├── shared/              # Utilitários compartilhados
├── view_model/          # ViewModels para estado da UI
└── widgets/             # Widgets reutilizáveis
```

## Padrões de Design

### Service Locator

O projeto utiliza um **Service Locator** centralizado (`service_locator.dart`) para injeção de dependência:

- **Singleton**: Serviços únicos (repositórios)
- **Factory**: Serviços instanciados sob demanda (controladores)
- **RepositoryMode**: Configuração de ambiente (mock, api, local)

```dart
// Exemplo de uso
ServiceLocator.instance.registerSingleton<IRepository<Category>>(
  () => InMemoryCategoryRepository(),
);

final repo = ServiceLocator.instance.get<IRepository<Category>>();
```

### Controladores Genéricos

A classe base `Controller<E>` define operações CRUD padronizadas:

- `save()`: Criar/atualizar entidades
- `delete()`: Remover entidades
- `findAll()`: Listar todas as entidades
- `reset()`: Limpar estado
- `fromEntity()`: Carregar dados de uma entidade

### Repositórios

Interfaces definem contratos para acesso a dados:

```dart
abstract class IAccountRepository {
  Future<List<Account>> getAll();
  Future<void> add(Account transaction);
  // ...
}
```

Implementações intercambiáveis via `RepositoryMode`:

- **Mock**: Dados em memória para desenvolvimento/testes
- **API**: Consumo de endpoints REST
- **Local**: Armazenamento local (a implementar)

### Entidades

Todas as entidades estendem `Entity<T>`:

- Serialização JSON/map
- Identificadores (id, publicId)
- Métodos `toMap()`, `fromMap()`, `toJson()`, `fromJson()`

## Gerenciamento de Estado

### Flutter Riverpod

O projeto utiliza **Riverpod** para gerenciamento de estado reativo:

```dart
final themeProvider = StateNotifierProvider<ThemeController, ThemeData>((ref) {
  return ThemeController();
});
```

### ViewModels

ViewModels seguem o padrão `EntityViewModel<T>` para estado de formulários e telas.

## Validação

Sistema de validação modular em `shared/validator/`:

- `ValidatorCallback`: Validações síncronas
- `ValidationRule`: Regras compostas
- `ValidatorService`: Orquestração de validações
- `ValidationResult`: Resultados padronizados

## Utilitários

### Formatters

- `CurrencyInputFormatter`: Formatação de valores monetários
- `DateInputFormatter`: Formatação de datas
- `PhoneInputFormatter`: Formatação de telefones

### Criptografia

- `AES256Encryption`: Criptografia AES-256
- `EncryptionContext`: Contexto de segurança
- Interfaces para algoritmos intercambiáveis

### Callbacks Tipados

- `ResultActionCallback<T, R>`: Ações assíncronas encadeadas
- `FutureValueSetter<T>`: Setters assíncronos
- `ErrorCallback`: Tratamento de erros padronizado

## Estrutura de Páginas

### Páginas Genéricas

O projeto possui páginas genéricas para operações CRUD:

- `generic_form/base_form_state.dart`: Estado base para formulários
- `generic_form/generic_list_view.dart`: Listagens reutilizáveis
- `generic_search_screen.dart`: Telas de busca padronizadas

### Factory de Páginas

Interfaces `IPageFactory` permitem troca de implementações (ex: Riverpod) sem acoplamento.

## Temas

Sistema de temas com `StateNotifier`:

- `AppTheme.defaultTheme()`: Tema claro personalizado
- `ThemeData.dark()`: Tema escuro padrão
- `toggleTheme()`: Alternância em tempo real

## Validações de campos nos formulários

- Garanta as validações para todos os campos de formulário para que os registros não sejam são com informações incorretas.

## Próximas Evoluções

1. **Local Storage**: Implementar repositórios locais (SQLite/SharedPreferences)
2. **API Real**: Completar integração com backend
3. **Testes**: Expandir cobertura com repositórios mock
4. **Internationalization**: Suporte a múltiplos idiomas (pacote `intl` já incluso)

## Comandos Úteis

```bash
# Desenvolvimento com mocks
setupRepositories(mode: RepositoryMode.mock)

# Produção com API
setupRepositories(mode: RepositoryMode.api)

# Testes unitários
flutter test
```

## Dependências Chave

| Pacote               | Finalidade              |
| -------------------- | ----------------------- |
| `flutter_riverpod`   | Gerenciamento de estado |
| `shared_preferences` | Armazenamento local     |
| `http`               | Requisições HTTP        |
| `encrypt`            | Criptografia            |
| `logger`             | Logging                 |
| `fl_chart`           | Gráficos e dashboards   |
| `google_fonts`       | Tipografia              |
| `uuid`               | Geração de IDs únicos   |

</content>
