import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';

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
            switch (e.response!.statusCode) {
              case 401:
                throw DioException(
                  requestOptions: e.requestOptions,
                  response: e.response,
                  error: 'Erro de autenticação: API Key inválida',
                );
              case 404:
                throw DioException(
                  requestOptions: e.requestOptions,
                  response: e.response,
                  error: 'Recurso não encontrado',
                );
              default:
                throw DioException(
                  requestOptions: e.requestOptions,
                  response: e.response,
                  error: 'Erro na requisição: ${e.message}',
                );
            }
          } else {
            throw DioException(
              requestOptions: e.requestOptions,
              error: 'Falha de conexão: ${e.message}',
            );
          }
        },
      ),
    );
  }

  Dio get dio => _dio;
}
