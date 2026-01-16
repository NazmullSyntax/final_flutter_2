import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main_home_page.dart';
import 'orders_page.dart';

class OrderConfirmationPage extends StatelessWidget {
  final String orderId;
  final double total;
  final VoidCallback onComplete;

  const OrderConfirmationPage({
    super.key,
    required this.orderId,
    required this.total,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Order Successful!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Order ID: $orderId',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Amount'),
                          Text(
                            '৳${NumberFormat('#,##0').format(total)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Date'),
                          Text('2-3 Working Days'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  onComplete();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainHomePage(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text('Return to Homepage'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag),
                label: const Text('View My Orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}