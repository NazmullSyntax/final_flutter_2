import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      Order(
        id: 'ORD001',
        date: DateTime.now().subtract(const Duration(days: 2)),
        total: 149999,
        status: 'Delivered',
        items: 1,
      ),
      Order(
        id: 'ORD002',
        date: DateTime.now().subtract(const Duration(days: 5)),
        total: 259998,
        status: 'Shipped',
        items: 2,
      ),
      Order(
        id: 'ORD003',
        date: DateTime.now().subtract(const Duration(days: 7)),
        total: 49999,
        status: 'Processing',
        items: 1,
      ),
      Order(
        id: 'ORD004',
        date: DateTime.now().subtract(const Duration(days: 15)),
        total: 109998,
        status: 'Cancelled',
        items: 3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Chip(
                        label: Text(order.status),
                        backgroundColor: _getStatusColor(order.status),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(order.date)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${order.items} items'),
                      Text(
                        '৳${NumberFormat('#,##0').format(order.total)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                          ),
                          child: const Text('Track'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green.shade100;
      case 'Shipped':
        return Colors.blue.shade100;
      case 'Processing':
        return Colors.orange.shade100;
      case 'Cancelled':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}