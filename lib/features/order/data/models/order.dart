import '../../../../core/errors/api_exception.dart';

class Order {
  final int orderId;
  final String status;
  final String? paymentUrl;

  const Order({
    required this.orderId,
    required this.status,
    required this.paymentUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final int? orderId = _parseInt(json['order_id']);
    final String status = (json['status'] ?? '').toString().trim();
    final String? paymentUrl = json['payment_url']?.toString();

    if (orderId == null || status.isEmpty) {
      throw const ApiException('Некорректный ответ сервера');
    }

    return Order(
      orderId: orderId,
      status: status,
      paymentUrl: paymentUrl,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value.toString());
  }
}
