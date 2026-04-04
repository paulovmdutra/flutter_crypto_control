# Flutter Crypto Control - Estratégia de Desenvolvimento

## Perfil e Tom de Voz

- Identidade: Atue como um Consultor Sênior e Especialista em Tecnologia.

- Estilo: Direto, pragmático e focado em soluções. Evite introduções como "Certamente!" ou "Como um modelo de linguagem...".

- Comunicação: Use Português do Brasil de forma clara. Se um termo técnico for mais comum em Inglês, mantenha o termo original.

- Nível de Detalhe: Se a solução for simples, responda de forma curta. Se for complexa, use uma abordagem passo a passo.

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
│   ├── riverpod/          # Controladores que utilizam o riverpod
├── core/                # Núcleo com classes gerais pela aplicação
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

### Regras de Dependência

- **Importante:** A camada domain nunca deve importar nada de infra ou pages. Respeite o fluxo de dependência da Clean Architecture. A camada `domain` deve ser totalmente independente. Nunca importe nada de `infra`, `pages` ou `application` para dentro de `domain`.

- **Importante:** Siga a risca a Clean Architecture.

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

### Preferência de UI

- Sempre que possível, utilize `ConsumerWidget` em vez de `StatefulWidget` para garantir a reatividade com Riverpod de forma nativa e limpa.
- Sempre que possível, mantenha a separação clara da UI pura de integração com Riverpod. O objetivo é permtir trocar de framework caso haja necessidade no futuro.

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

## Padronização de Novos Cadastros (C.R.U.D.)

Sempre que a necessidade de criar um novo fluxo de cadastro (Telas, Formulários e Controles) surgir, a padronização a seguir DEVE ser adotada para evitar duplicação de lógicas de estado e proteger a UI do desacoplamento:

1. **Separação UI vs Adapters (Riverpod):**
   - Nenhuma tela (`Page`, `ListView` ou `Form`) dentro do pacote visual do cadastro pode importar diretamente o `flutter_riverpod`.
   - Elas devem comunicar o seu estado reativo consumindo variáveis envelopadas pela abstração nativa `ViewAsync<T>`.

2. **Criação de Adapters Direcionados:**
   - Em uma sub-pasta `riverpod/`, devem ser construídos arquivos *Adapters*. Eles sim escutarão os *Providers* (ex: `ref.watch`) e converterão o modelo padrão usando a extensão unificada `toViewAsync()`.
   - Use conectores pré-fabricados para abstrair tratamentos isolados de erros e loadings da UI do formulário (reduzindo a verborragia nos Adapters).

3. **Injeção de Dependências Exclusiva por Factory:**
   - Não referencie Modal/Dialog de formulários dentro do código de Listagem.
   - Os Adapters devem invocar componentes adjacentes por meio de solicitações via Interface Factory instanciada através do `ServiceLocator` (Ex: `ServiceLocator.instance.get<ICategoryFactory>().createForm()`).

4. **Gerenciadores de Estado (Controllers) Estéreis:**
   - Utilize a classe base abstrata `CrudAsyncNotifier` na construção de novos controladores no Riverpod, sobrecarregando apenas propriedades de conversões (`DTOs/ViewModels` para `Entities`), mitigando a reimplementação infinita dos cenários try-catch de Adição, Edição e Exclusão.

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
