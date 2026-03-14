import 'package:flutter/material.dart';

import '../../data/models/order.dart';

class OrderResultCard extends StatelessWidget {
  final Order order;

  const OrderResultCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Заказ успешно создан',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            Text('order_id: ${order.orderId}'),
            Text('status: ${order.status}'),
            Text('payment_url: ${order.paymentUrl ?? 'null'}'),
          ],
        ),
      ),
    );
  }
}
