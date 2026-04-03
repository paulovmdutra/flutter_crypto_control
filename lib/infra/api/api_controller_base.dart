import 'dart:async';

import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/flattened_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

abstract class IHttpClient {
  Future<ServiceResult> post(String method, String bodyJson);

  Future<ServiceResult> delete(String method, {Object? body});

  Future<ServiceResult> put(String method, String bodyJson);

  Future<ServiceResult> get(String method, {Map<String, String>? parameters});
}

class ApiControllerBase {
  String? urlBase = 'localhost:5010';
  String? endPointBase;

  ApiControllerBase({this.urlBase = 'localhost:5010', this.endPointBase});

  //Cabeçalhos padrão para todas as requisições. Caso seja necessário adicionar ou alterar algum cabeçalho
  //basta sobrescrever o Map em uma classe filha ou adicionar novos valores, como tokens de autenticação.
  Map<String, String> _headers = {'Content-type': 'application/json'};

  //Adiciona ou atualiza os cabeçalhos padrão
  void setDefaultHeader(String key, String value) {
    _headers[key] = value;
  }

  Future<CommonResult<T?>> callAction<T>(
    String? endPoint,
    Future<http.Response> Function(Uri url) requestCall, {
    Object? body,
    T? Function(dynamic json)? fromJson,
  }) async {
    try {
      if (urlBase == null) {
        return CommonResult.fail(
          message: 'URL base não informada.',
          error: Error(
            code: AppStatusCodes.internalError,
            message: "URL base não informada.",
          ),
        );
      }

      // 💡 Lógica de URL Aprimorada
      String finalPath;

      // Combina o prefixo (endPointBase) com o caminho específico (endPoint)
      if (endPointBase != null && endPoint != null) {
        // Garante que o path comece com '/' se não tiver e combina os dois
        finalPath = Uri.parse(endPointBase!).resolve(endPoint).path;
      } else if (endPoint != null) {
        finalPath = endPoint;
      } else if (endPointBase != null) {
        finalPath = endPointBase!;
      } else {
        // Se nenhum for fornecido, trate como erro (já tratado acima, mas melhor prevenir)
        return CommonResult.fail(
          message: 'Nenhum endpoint fornecido.',
          error: Error(
            code: AppStatusCodes.internalError,
            message: "Nenhum endpoint fornecido.",
          ),
        );
      }

      // O último argumento do Uri.http é o path, que deve ser a combinação correta
      var url = Uri.http(urlBase!, finalPath);

      var response = await requestCall(url);

      switch (response.statusCode) {
        case 200:
          if (response.body.isEmpty) {
            if (fromJson != null) {
              // Se fromJson é exigido, mas o corpo está vazio, é um erro de API
              return CommonResult.fail(
                error: CommonError.general(
                  message: 'Resposta 200 com corpo vazio, mas dados esperados.',
                ),
                statusCode: response.statusCode,
              );
            }
            // Sucesso sem dados
            return CommonResult.success(
              data: null,
              statusCode: response.statusCode,
            );
          }

          // Corpo não está vazio. Tenta decodificar e deserializar.
          var decodeBody = convert.jsonDecode(response.body);
          return CommonResult.fromJson(decodeBody, fromJson);
        default:
          var decodeBody = convert.jsonDecode(response.body);

          // Tenta deserializar a resposta de erro da API.
          // Se a API retornar um corpo de erro no formato esperado:
          if (decodeBody is Map<String, dynamic> &&
              decodeBody['error'] != null) {
            return CommonResult.fromJson(decodeBody, fromJson);
          } else {
            // Cria um erro genérico, tentando mapear o status HTTP para um AppStatusCodes
            int appStatusCode = HttpStatusMapper.toHttpStatus(
              response.statusCode,
            );

            // Caso contrário, cria um erro genérico.
            return CommonResult.fail(
              error: Error(
                code: appStatusCode,
                message: 'Erro na requisição. Código: ${response.statusCode}',
                details: response.body,
              ),
              message: 'Erro HTTP ${response.statusCode}. Resposta inesperada.',
              statusCode: response.statusCode,
            );
          }
      }
    } on SocketException catch (e) {
      return CommonResult.fail(
        error: Error(code: AppStatusCodes.internalError, message: e.message),
        message: 'Não foi possível completar a requisição.',
      );
    } on HttpException catch (e) {
      return CommonResult.fail(
        error: Error(code: AppStatusCodes.internalError, message: e.message),
        message: 'Não foi possível completar a requisição.',
      );
    } on TimeoutException catch (e) {
      return CommonResult<T>.fail(
        error: CommonError.general(
          message: 'A requisição expirou. Tente novamente.',
        ),
        statusCode: 408, // Request Timeout HTTP
      );
    } on FormatException catch (e) {
      //Tratamento de Erro de JSON (resposta da API não é JSON válido)
      // Este erro é diferente do erro de parsing interno que você tratou no fromJson.
      // Este ocorre no jsonDecode(response.body).
      print('Erro ao decodificar JSON: $e');
      return CommonResult<T>.fail(
        error: CommonError.general(
          message: 'A resposta da API não é um JSON válido.',
          ex: FlattenedException(
            message: e.toString(),
            stackTrace: StackTrace.current.toString(),
          ),
        ),
        statusCode: AppStatusCodes.externalServiceInvalidResponse,
      );
    } on Exception catch (e) {
      print('Erro Inesperado na chamada da API: $e');
      return CommonResult<T>.fail(
        error: CommonError.general(
          message: 'Ocorreu um erro desconhecido.',
          ex: FlattenedException(
            message: e.toString(),
            stackTrace: StackTrace.current.toString(),
          ),
        ),
        statusCode: AppStatusCodes.unknown,
      );
    }
  }

  Future<CommonResult<T?>> post<T>({
    String? endPoint,
    Object? body,
    T? Function(dynamic json)? fromJson,
  }) async {
    // final requestBody = body != null ? convert.jsonEncode(body) : null;
    return callAction<T>(endPoint, (Uri url) {
      return http.post(url, body: body, headers: _headers);
    }, fromJson: fromJson);
  }

  Future<CommonResult<T?>> put<T>({
    String? endPoint,
    Object? body,
    T? Function(dynamic json)? fromJson,
  }) async {
    return callAction<T>(endPoint, (Uri url) {
      return http.put(url, body: body, headers: _headers);
    }, fromJson: fromJson);
  }

  Future<CommonResult<T?>> get<T>({
    String? endPoint,
    T? Function(dynamic json)? fromJson,
  }) async {
    return callAction<T>(endPoint, (Uri url) {
      return http.get(url, headers: _headers);
    }, fromJson: fromJson);
  }

  Future<CommonResult<T?>> delete<T>({
    String? endPoint,
    Object? body,
    T? Function(dynamic json)? fromJson,
  }) async {
    return callAction<T>(endPoint, (Uri url) {
      return http.delete(url, body: body, headers: _headers);
    }, fromJson: fromJson);
  }
}
