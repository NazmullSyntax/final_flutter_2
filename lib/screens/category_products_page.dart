import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';
import '../screens/product_detail_page.dart';

class CategoryProductsPage extends StatefulWidget {
  final List<Product> products;
  final Function(Product, {int quantity}) onAddToCart;
  final String? selectedCategory;

  const CategoryProductsPage({
    super.key,
    required this.products,
    required this.onAddToCart,
    this.selectedCategory,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Mobile Phones', 'icon': Icons.phone_android, 'count': 125},
    {'name': 'Laptops', 'icon': Icons.laptop, 'count': 89},
    {'name': 'Televisions', 'icon': Icons.tv, 'count': 67},
    {'name': 'Headphones', 'icon': Icons.headphones, 'count': 234},
    {'name': 'Cameras', 'icon': Icons.camera, 'count': 45},
    {'name': 'Home Appliances', 'icon': Icons.kitchen, 'count': 156},
    {'name': 'Kitchen Appliances', 'icon': Icons.microwave, 'count': 98},
    {'name': 'Fashion', 'icon': Icons.shopping_bag, 'count': 456},
    {'name': 'Shoes', 'icon': Icons.sports, 'count': 234},
    {'name': 'Smart Watches', 'icon': Icons.watch, 'count': 78},
    {'name': 'Tablets', 'icon': Icons.tablet, 'count': 56},
    {'name': 'Audio', 'icon': Icons.speaker, 'count': 123},
    {'name': 'Gaming', 'icon': Icons.videogame_asset, 'count': 89},
    {'name': 'Monitors', 'icon': Icons.desktop_windows, 'count': 45},
    {'name': 'Watches', 'icon': Icons.access_time, 'count': 67},
  ];

  String? _selectedCategory;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  List<Product> get filteredProducts {
    List<Product> filtered = widget.products;
    
    // Filter by category
    if (_selectedCategory != null && _selectedCategory != 'All Categories') {
      filtered = filtered.where((product) => product.category == _selectedCategory).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) {
        return product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedCategory ?? 'All Categories',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${filteredProducts.length} products found',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search in ${_selectedCategory ?? 'all categories'}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Categories Filter Bar
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _buildCategoryFilterChip('All Categories', null),
                ..._categories.map((category) => 
                  _buildCategoryFilterChip(category['name'], category['name'])
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No products found',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _selectedCategory != null
                              ? 'Try another category or search term'
                              : 'No products match your search',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterChip(String label, String? category) {
    bool isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
          });
        },
        backgroundColor: Colors.grey.shade100,
        selectedColor: const Color(0xFF2E7D32).withValues(alpha: 0.2),
        checkmarkColor: const Color(0xFF2E7D32),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF2E7D32) : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? const Color(0xFF2E7D32) : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: product,
              onAddToCart: () {
                widget.onAddToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    height: 120,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 60,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                if (product.discount > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${product.discount}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '৳${NumberFormat('#,##0').format(product.discountedPrice)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (product.discount > 0)
                        Text(
                          '৳${NumberFormat('#,##0').format(product.price)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(
                          fontSize: 12,
                          color: product.stock > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onAddToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}