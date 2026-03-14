import 'package:flutter/material.dart';

import '../../data/services/order_api.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_result_card.dart';

class OrderScreen extends StatefulWidget {
  final int userId;
  final int serviceId;
  final OrderApi api;

  const OrderScreen({
    super.key,
    required this.userId,
    required this.serviceId,
    required this.api,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final OrderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OrderController(api: widget.api);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await _controller.submitOrder(
      userId: widget.userId,
      serviceId: widget.serviceId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание заказа'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              final bool isLoading = _controller.state == OrderState.loading;

              String buttonText = 'Создать заказ';
              if (_controller.state == OrderState.loading) {
                buttonText = 'Создание...';
              } else if (_controller.state == OrderState.error) {
                buttonText = 'Повторить попытку';
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'userId: ${widget.userId}\nserviceId: ${widget.serviceId}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    if (isLoading) ...<Widget>[
                      const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 16),
                    ],
                    if (_controller.state == OrderState.error &&
                        _controller.errorMessage != null) ...<Widget>[
                      Text(
                        _controller.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (_controller.state == OrderState.success &&
                        _controller.order != null) ...<Widget>[
                      OrderResultCard(order: _controller.order!),
                      const SizedBox(height: 16),
                    ],
                    ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child: Text(buttonText),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
