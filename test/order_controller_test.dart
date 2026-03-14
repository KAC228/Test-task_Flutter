import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_order_creation_test_task/features/order/data/services/mock_order_api.dart';
import 'package:flutter_order_creation_test_task/features/order/presentation/controllers/order_controller.dart';

void main() {
  test('submitOrder sets success state on success', () async {
    final OrderController controller = OrderController(
      api: MockOrderApi(shouldFail: false),
    );

    await controller.submitOrder(userId: 1, serviceId: 2);

    expect(controller.state, OrderState.success);
    expect(controller.order, isNotNull);
    expect(controller.errorMessage, isNull);
  });

  test('submitOrder sets error state on failure', () async {
    final OrderController controller = OrderController(
      api: MockOrderApi(shouldFail: true),
    );

    await controller.submitOrder(userId: 1, serviceId: 2);

    expect(controller.state, OrderState.error);
    expect(controller.order, isNull);
    expect(controller.errorMessage, isNotNull);
  });
}
