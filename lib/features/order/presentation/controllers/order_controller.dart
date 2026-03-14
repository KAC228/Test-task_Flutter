import 'package:flutter/foundation.dart';

import '../../../../core/errors/api_exception.dart';
import '../../data/models/order.dart';
import '../../data/services/order_api.dart';

enum OrderState {
  initial,
  loading,
  success,
  error,
}

class OrderController extends ChangeNotifier {
  final OrderApi api;

  OrderState state = OrderState.initial;
  String? errorMessage;
  Order? order;

  OrderController({required this.api});

  Future<void> submitOrder({
    required int userId,
    required int serviceId,
  }) async {
    state = OrderState.loading;
    errorMessage = null;
    order = null;
    notifyListeners();

    try {
      final Order result = await api.createOrder(
        userId: userId,
        serviceId: serviceId,
      );

      order = result;
      state = OrderState.success;
    } on ApiException catch (e) {
      errorMessage = e.message;
      state = OrderState.error;
    } catch (e) {
      errorMessage = 'Неизвестная ошибка: $e';
      state = OrderState.error;
    }

    notifyListeners();
  }
}
