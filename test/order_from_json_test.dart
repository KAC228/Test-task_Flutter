import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_order_creation_test_task/features/order/data/models/order.dart';

void main() {
  test('Order.fromJson parses valid json', () {
    final Order order = Order.fromJson(<String, dynamic>{
      'order_id': 1,
      'status': 'created',
      'payment_url': 'https://example.com/pay/1',
    });

    expect(order.orderId, 1);
    expect(order.status, 'created');
    expect(order.paymentUrl, 'https://example.com/pay/1');
  });

  test('Order.fromJson throws on invalid payload', () {
    expect(
      () => Order.fromJson(<String, dynamic>{
        'status': '',
      }),
      throwsException,
    );
  });
}
