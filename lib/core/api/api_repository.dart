import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc_template/core/models/api/response_model.dart';

import '../enum/http_method_enum.dart';
import '../models/api/list_pagination_response.dart';
import '../utils/log.dart';
import 'package:http/http.dart';

import '../models/api/token.dart';

class ApiRepository {
  final _client = Client();

  Future<ResponseModel<T>> performRequest<T>({
    required String url,
    required HttpMethodEnum method,
    dynamic body,
    JWTToken? token,
    Map<String, String>? headers,
    Map<String, String>? query,
    String? contentType,
    T Function(dynamic)? toResponseModel,
  }) async {
    try {
      final Map<String, String> headersMap = headers ?? <String, String>{};
      late final Response response;
      if (token != null) {
        headersMap['Authorization'] = 'Bearer ${token.accessToken}';
      }
      headersMap['Content-Type'] = contentType ?? 'application/json';

      final uri = Uri.parse(url)..replace(queryParameters: query);

      switch (method) {
        case HttpMethodEnum.get:
          response = await _client.get(
            uri,
            headers: headersMap,
          );

        case HttpMethodEnum.post:
          response = await _client.post(
            uri,
            headers: headersMap,
            body: body != null ? jsonEncode(body) : <String, String>{},
          );

        case HttpMethodEnum.put:
          response = await _client.put(
            uri,
            headers: headersMap,
            body: body != null ? jsonEncode(body) : <String, String>{},
          );

        case HttpMethodEnum.delete:
          response = await _client.delete(
            uri,
            headers: headersMap,
            body: body != null ? jsonEncode(body) : <String, String>{},
          );
          break;

        case HttpMethodEnum.patch:
          response = await _client.patch(
            uri,
            headers: headersMap,
            body: body != null ? jsonEncode(body) : <String, String>{},
          );
      }

      _logResponse(response);

      if (response.statusCode < 200 || response.statusCode > 299) {
        return ResponseModel(success: false, message: response.body);
      }

      return ResponseModel<T>(
        success: true,
        result: toResponseModel != null ? toResponseModel(response.body) : null,
      );
    } catch (e) {
      return ResponseModel(success: false, message: e.toString());
    }
  }

  ListPaginationResponse<T> listPaginationResponseFormat<T>(
      Map<String, dynamic> body, List<T> data) {
    return ListPaginationResponse<T>(
      items: data,
      total: body['totalElements'] as int,
      page: body['page'] as int,
      pages: body['pages'] as int,
      perPage: body['perPage'] as int,
    );
  }

  Future _logResponse(Response response, {bool mock = false}) async {
    await appLogger(
      message: 'Mock: $mock\n'
          'Request: ${response.request?.method} => ${response.request?.url}\n'
          'Status: ${response.statusCode}\n'
          'Request Header: ${response.request?.headers}\n'
          'Request Query: ${response.request?.url.query}\n'
          'Request Body: ${response.request.toString()}\n'
          'Response Header: ${response.headers}\n'
          'Response Body: ${response.body}\n',
      source: '|ApiRepository| _logResponse()',
    );
  }
}
