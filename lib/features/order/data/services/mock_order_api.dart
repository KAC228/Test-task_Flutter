import 'dart:async';

import '../../../../core/errors/api_exception.dart';
import '../models/order.dart';
import 'order_api.dart';

class MockOrderApi implements OrderApi {
  final Duration delay;
  final bool shouldFail;

  MockOrderApi({
    this.delay = const Duration(seconds: 2),
    this.shouldFail = false,
  });

  @override
  Future<Order> createOrder({
    required int userId,
    required int serviceId,
  }) async {
    await Future.delayed(delay);

    if (shouldFail) {
      throw const ApiException('Демонстрационная ошибка сервера');
    }

    return Order(
      orderId: 12345,
      status: 'created',
      paymentUrl: 'https://example.com/payment/12345',
    );
  }
}
