import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../core/errors/api_exception.dart';
import '../models/order.dart';
import 'order_api.dart';

class HttpOrderApi implements OrderApi {
  final String baseUrl;
  final http.Client _client;

  HttpOrderApi({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<Order> createOrder({
    required int userId,
    required int serviceId,
  }) async {
    final Uri uri = Uri.parse('$baseUrl/api/orders');

    try {
      final http.Response response = await _client
          .post(
            uri,
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              'userId': userId,
              'serviceId': serviceId,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final dynamic decoded = jsonDecode(response.body);

        if (decoded is! Map<String, dynamic>) {
          throw const ApiException('Некорректный формат ответа сервера');
        }

        return Order.fromJson(decoded);
      }

      if (response.statusCode >= 400) {
        throw ApiException(
          _extractErrorMessage(response),
          statusCode: response.statusCode,
        );
      }

      throw ApiException(
        'Неожиданный статус ответа: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    } on SocketException {
      throw const ApiException('Нет подключения к интернету');
    } on TimeoutException {
      throw const ApiException('Превышено время ожидания ответа (10 секунд)');
    } on http.ClientException catch (e) {
      throw ApiException('Ошибка сети: ${e.message}');
    } on FormatException {
      throw const ApiException('Сервер вернул некорректный JSON');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Неизвестная ошибка: $e');
    }
  }

  String _extractErrorMessage(http.Response response) {
    if (response.body.trim().isEmpty) {
      return 'Ошибка сервера';
    }

    try {
      final dynamic decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        final dynamic message = decoded['message'] ??
            decoded['error'] ??
            decoded['detail'];

        if (message != null && message.toString().trim().isNotEmpty) {
          return message.toString();
        }
      }
    } catch (_) {
      return response.body;
    }

    return response.body;
  }
}
