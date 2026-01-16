import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product.dart';
import '../models/store_comparison.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showStoreDetails(StoreComparison store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StoreDetailsSheet(store: store, onBuyNow: _launchUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          bottom: const TabBar(
            indicatorColor: Color(0xFF2E7D32),
            labelColor: Color(0xFF2E7D32),
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Compare'),
              Tab(text: 'Specs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Details Tab
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    color: Colors.grey.shade100,
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 150,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.category,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '৳${NumberFormat('#,##0').format(widget.product.discountedPrice)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (widget.product.discount > 0)
                              Text(
                                '৳${NumberFormat('#,##0').format(widget.product.price)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${widget.product.discount}% OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            Text(' ${widget.product.rating} (500+ Reviews)'),
                            const Spacer(),
                            Chip(
                              label: Text(
                                widget.product.stock > 0 ? 'In Stock' : 'Out of Stock',
                                style: TextStyle(
                                  color: widget.product.stock > 0 ? Colors.green : Colors.red,
                                ),
                              ),
                              backgroundColor: widget.product.stock > 0
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Quantity Selector
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Decrease Button
                            InkWell(
                              onTap: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            // Quantity Display
                            Container(
                              width: 80,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '$_quantity',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Increase Button
                            InkWell(
                              onTap: () {
                                if (_quantity < widget.product.stock) {
                                  setState(() {
                                    _quantity++;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Only ${widget.product.stock} items available in stock'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'In Stock: ${widget.product.stock}',
                              style: TextStyle(
                                color: widget.product.stock > 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.description,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  widget.onAddToCart();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${widget.product.name} added to cart'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text('Add to Cart'),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF2E7D32)),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  for (int i = 0; i < _quantity; i++) {
                                    widget.onAddToCart();
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('$_quantity ${widget.product.name} added to cart'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_bag),
                                label: const Text('Buy Now'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price Comparison Tab
            _buildPriceComparisonTab(),

            // Specifications Tab
            _buildSpecificationsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceComparisonTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Compare Prices Across Stores',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Find the best deal from different stores in Bangladesh',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // Price Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Our Price', style: TextStyle(fontSize: 16)),
                      Text(
                        '৳${NumberFormat('#,##0').format(widget.product.discountedPrice)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Average Price', style: TextStyle(fontSize: 16)),
                      Text(
                        '৳${NumberFormat('#,##0').format(_calculateAveragePrice())}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Lowest Price', style: TextStyle(fontSize: 16)),
                      Text(
                        '৳${NumberFormat('#,##0').format(_findLowestPrice())}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Store Comparisons
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.product.storeComparisons.length,
            itemBuilder: (context, index) {
              final store = widget.product.storeComparisons[index];
              return _buildStoreComparisonCard(store);
            },
          ),
          const SizedBox(height: 20),
          // Quick Comparison Tips
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shopping Tips',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTipItem(
                    Icons.local_shipping,
                    'Free delivery available on most stores for orders above ৳5000',
                  ),
                  _buildTipItem(
                    Icons.verified,
                    'Check warranty and return policy before purchase',
                  ),
                  _buildTipItem(
                    Icons.star,
                    'Read customer reviews for better decision making',
                  ),
                  _buildTipItem(
                    Icons.schedule,
                    'Compare delivery times for urgent needs',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreComparisonCard(StoreComparison store) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      store.storeName.substring(0, 1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.storeName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' ${store.storeRating}'),
                          const SizedBox(width: 8),
                          Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                          Text(
                            ' ${store.storeAddress}',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '৳${NumberFormat('#,##0').format(store.price)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            store.isAvailable ? Icons.check_circle : Icons.cancel,
                            color: store.isAvailable ? Colors.green : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            store.isAvailable ? 'In Stock' : 'Out of Stock',
                            style: TextStyle(
                              color: store.isAvailable ? Colors.green : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.local_shipping, size: 16, color: Colors.grey.shade600),
                          Text(
                            ' ${store.deliveryTime}',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Stock: ${store.stock} units',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: store.isAvailable
                          ? () {
                              _showStoreDetails(store);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                      ),
                      child: const Text('View Details'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: store.isAvailable
                          ? () {
                              _launchUrl(store.storeLink);
                            }
                          : null,
                      child: const Text('Visit Store'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Specifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: widget.product.specifications.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Warranty & Return Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Warranty & Returns',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    Icons.verified,
                    'Warranty',
                    '1 Year Brand Warranty',
                  ),
                  _buildInfoItem(
                    Icons.refresh,
                    'Return Policy',
                    '7 Days Easy Return',
                  ),
                  _buildInfoItem(
                    Icons.support_agent,
                    'Customer Support',
                    '24/7 Support Available',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  value,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateAveragePrice() {
    if (widget.product.storeComparisons.isEmpty) return widget.product.discountedPrice;
    double sum = 0;
    int count = 0;
    for (var store in widget.product.storeComparisons) {
      if (store.isAvailable) {
        sum += store.price;
        count++;
      }
    }
    return count > 0 ? sum / count : widget.product.discountedPrice;
  }

  double _findLowestPrice() {
    if (widget.product.storeComparisons.isEmpty) return widget.product.discountedPrice;
    double lowest = double.infinity;
    for (var store in widget.product.storeComparisons) {
      if (store.isAvailable && store.price < lowest) {
        lowest = store.price;
      }
    }
    return lowest == double.infinity ? widget.product.discountedPrice : lowest;
  }
}

class StoreDetailsSheet extends StatelessWidget {
  final StoreComparison store;
  final Function(String) onBuyNow;

  const StoreDetailsSheet({
    super.key,
    required this.store,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            store.storeName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              Text(' ${store.storeRating} Store Rating'),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: store.isAvailable ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  store.isAvailable ? 'Available' : 'Unavailable',
                  style: TextStyle(
                    color: store.isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Price Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price', style: TextStyle(fontSize: 16)),
                      Text(
                        '৳${NumberFormat('#,##0').format(store.price)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Stock Available', style: TextStyle(color: Colors.grey)),
                            Text(
                              '${store.stock} units',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Delivery Time', style: TextStyle(color: Colors.grey)),
                            Text(
                              store.deliveryTime,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Store Information
          const Text(
            'Store Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildStoreInfoItem(Icons.location_on, 'Address', store.storeAddress),
          _buildStoreInfoItem(Icons.phone, 'Phone', store.storePhone),
          _buildStoreInfoItem(Icons.security, 'Warranty', store.warranty),
          _buildStoreInfoItem(Icons.refresh, 'Return Policy', store.returnPolicy),
          const SizedBox(height: 20),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    onBuyNow(store.storeLink);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Buy Now'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF2E7D32)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    // Add to cart logic here
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                onBuyNow(store.storeLink);
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('Visit Store Website'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  value,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}