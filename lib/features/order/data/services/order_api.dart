import '../models/order.dart';

abstract class OrderApi {
  Future<Order> createOrder({
    required int userId,
    required int serviceId,
  });
}
