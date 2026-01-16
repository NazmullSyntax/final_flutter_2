import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cart_item.dart';
import 'order_confirmation_page.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double total;
  final VoidCallback onCheckoutComplete;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.total,
    required this.onCheckoutComplete,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPaymentMethod = 0;
  final List<String> _paymentMethods = [
    'bKash',
    'Nagad',
    'Rocket',
    'Card (Visa/Mastercard)',
    'Cash on Delivery',
  ];

  void _processPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Confirmation'),
        content: const Text('Are you sure you want to complete payment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmationPage(
                    orderId: 'ORD${DateTime.now().millisecondsSinceEpoch}',
                    total: widget.total + 60 + (widget.total * 0.05),
                    onComplete: widget.onCheckoutComplete,
                  ),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = widget.total + 60 + (widget.total * 0.05);
    final totalItems = widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('Abdur Rahman'),
                    const Text('Mobile: 01712345678'),
                    const Text('House #123, Road #45, Dhanmondi, Dhaka'),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: const Text('Change'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = widget.cartItems[index];
                        final product = cartItem.product;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('${index + 1}. ${product.name} (x${cartItem.quantity})'),
                              ),
                              Text(
                                '৳${NumberFormat('#,##0').format(cartItem.totalPrice)}',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal ($totalItems items)'),
                        Text('৳${NumberFormat('#,##0').format(widget.total)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Charge'),
                        Text('৳60'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tax (5%)'),
                        Text('৳${NumberFormat('#,##0').format(widget.total * 0.05)}'),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '৳${NumberFormat('#,##0').format(totalAmount)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _paymentMethods.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_paymentMethods[index]),
                          leading: Radio<int>(
                            value: index,
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                            activeColor: const Color(0xFF2E7D32),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}