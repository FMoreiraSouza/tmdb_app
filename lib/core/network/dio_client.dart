import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/network/failure.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          queryParameters: {'api_key': ApiConstants.apiKey},
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('Request: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('Error: ${e.message}');
          if (e.response != null) {
            final statusCode = e.response?.statusCode;
            if (statusCode == 401) {
              throw AuthorizationException('Erro de autenticação: API Key inválida');
            } else if (statusCode == 404) {
              throw RequestNotFoundException('Recurso não encontrado');
            } else if (statusCode == 429) {
              throw BadRequestException('Limite de requisições atingido');
            } else if ((statusCode ?? -1) >= 500) {
              throw UnavaliableServiceException('Serviço indisponível');
            } else {
              throw Failure('Erro na requisição: ${e.message}');
            }
          } else {
            throw ConnectionException('Falha de conexão: ${e.message}');
          }
        },
      ),
    );
  }

  Dio get dio => _dio;
}
