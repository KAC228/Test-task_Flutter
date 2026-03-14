import 'package:flutter/material.dart';

import 'features/order/data/services/http_order_api.dart';
import 'features/order/data/services/mock_order_api.dart';
import 'features/order/data/services/order_api.dart';
import 'features/order/presentation/screens/order_screen.dart';

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    const bool useMockApi = true;
    const bool simulateMockFailure = false;

    final OrderApi api = useMockApi
        ? MockOrderApi(shouldFail: simulateMockFailure)
        : HttpOrderApi(baseUrl: 'https://example.com');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order Creation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: OrderScreen(
        api: api,
        userId: 1,
        serviceId: 10,
      ),
    );
  }
}
