import 'dart:async';

import 'package:flutter_crypto_control/shared/app_response_models.dart';

/// ## Callbacks Assíncronos (Future) 🚀
/// Callbacks que executam operações assíncronas, como I/O, rede ou banco de dados.

// Assumindo que você tem uma classe ou enum para o resultado comum
// class CommonResult<T> { ... }

/// **FutureResultActionCallback<T, R>**
///
/// Um callback assíncrono projetado para encadear ou processar resultados.
///
/// - Recebe um valor opcional [R] (o resultado de entrada/anterior, ex: CommonResult<T?>?).
/// - Retorna um Future contendo um valor [R] (o novo resultado da ação, ex: CommonResult<T?>).
///
/// Se [T] e [R] forem o mesmo tipo, ele é útil para encadear operações.
// R é o tipo de resultado específico (ex: SuccessResult<T>, ErrorResult<T>, etc.)
// Assumindo que R sempre herdará de CommonResult<T?>.
typedef ResultActionCallback<T, R extends CommonResult<T?>> = Future<R> Function(R? data);

/// **FutureVoidCallback**
/// Uma função assíncrona que não recebe argumentos e retorna [Future<void>].
/// O uso do '?' permite que o callback seja opcional (null-safe).
/// Ex: Salvar dados, recarregar lista.
typedef FutureVoidCallback = Future<void> Function();

/// **FutureValueSetter<T>**
/// Uma função assíncrona que recebe um valor genérico [T] e retorna [Future<void>].
/// Útil para salvar ou atualizar um recurso baseado em um valor de entrada.
/// Ex: Deletar um item pelo ID, atualizar um campo com um novo valor.
typedef FutureValueSetter<T> = Future<void> Function(T value);

/// **FutureTCallback<T>**
/// Uma função assíncrona que não recebe argumentos, mas retorna um valor [T] no futuro.
/// Útil para buscar dados para um FutureBuilder.
/// Ex: Buscar um objeto específico, calcular um valor demorado.
typedef FutureTCallback<T> = Future<T> Function();

/// **FutureResultCallback<T, E>**
/// Uma função assíncrona que recebe um argumento de tipo [E] e retorna um valor de tipo [T] no futuro.
/// Ex: Buscar um objeto (T) com base em um critério (E).
typedef FutureResultCallback<T, E> = Future<T> Function(E argument);

// -----------------------------------------------------------------

/// ## Callbacks de Valor e Estado (Síncronos) 🔄
/// Callbacks que retornam ou modificam valores de forma síncrona.

/// **ValueGetter<T>**
/// Uma função síncrona que retorna um valor [T] e não recebe argumentos.
/// Útil para obter o valor inicial de uma variável ou propriedade.
/// Ex: Pegar o valor atual de um controlador.
typedef ValueGetter<T> = T Function();

/// **ValueChangedNullable<T>**
/// Uma função que aceita um valor genérico [T] que pode ser nulo ([T?]) e não retorna nada.
/// Útil para widgets de seleção que permitem desmarcar (nullificar) uma opção.
/// Ex: Um dropdown que permite "Nenhum Selecionado".
typedef ValueChangedNullable<T> = void Function(T? value);

/// **ValidatorCallback**
/// Uma função síncrona que recebe uma string opcional (o valor do campo) e retorna uma mensagem
/// de erro [String?] se o valor for inválido, ou [null] se for válido.
typedef ValidatorCallback = String? Function(String? value);

// -----------------------------------------------------------------

/// ## Callbacks de Erro e Transição 🚨

/// **ErrorCallback**
/// Um callback usado para notificar sobre exceções.
/// Recebe o objeto de erro [Object] e o [StackTrace] para fins de log ou exibição.
typedef ErrorCallback = void Function(Object error, StackTrace stackTrace);

/// **StateChangeCallback<T>**
/// Um callback que notifica sobre uma transição de estado.
/// Recebe o estado anterior ([oldState]) e o novo estado ([newState]).
/// Útil em pacotes de gerenciamento de estado para observadores.
typedef StateChangeCallback<T> = void Function(T oldState, T newState);
