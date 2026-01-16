import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/user_profile.dart';
import '../models/store_comparison.dart';
import 'category_products_page.dart';
import 'product_detail_page.dart';
import 'checkout_page.dart';
import 'edit_profile_page.dart';
import 'edit_address_page.dart';
import 'help_support_page.dart';
import 'about_us_page.dart';
import 'orders_page.dart';
import 'security_page.dart';
import 'auth_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];
  
  // User Profile
  UserProfile _userProfile = UserProfile(
    name: 'Abdur Rahman',
    email: 'rahman@gmail.com',
    phone: '01712345678',
    address: 'House #123, Road #45, Dhanmondi, Dhaka',
    gender: 'Male',
  );
  
  // Define all products here
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Samsung Galaxy S23 Ultra',
      price: 159999,
      discountedPrice: 149999,
      stock: 45,
      category: 'Mobile Phones',
      description: '12GB RAM, 256GB Storage, 200MP Camera with Night Mode, S Pen included, 5000mAh battery',
      discount: 6,
      rating: 4.8,
      specifications: {
        'Display': '6.8" Dynamic AMOLED 2X',
        'Processor': 'Snapdragon 8 Gen 2',
        'RAM': '12GB',
        'Storage': '256GB',
        'Camera': '200MP + 12MP + 10MP',
        'Battery': '5000mAh',
        'OS': 'Android 13',
      },
      storeComparisons: [
        StoreComparison(
          storeName: 'Daraz',
          price: 155000,
          stock: 25,
          deliveryTime: '2-3 days',
          storeRating: 4.5,
          storeLink: 'https://www.daraz.com.bd',
          storeAddress: 'Dhaka, Bangladesh',
          storePhone: '09612422222',
          returnPolicy: '7 Days Return',
          warranty: '1 Year Brand Warranty',
          isAvailable: true,
        ),
      ],
    ),
    Product(
      id: '2',
      name: 'iPhone 15 Pro Max',
      price: 199999,
      discountedPrice: 189999,
      stock: 28,
      category: 'Mobile Phones',
      description: 'A17 Pro Chip, Titanium Design, 5x Telephoto Zoom, Dynamic Island, 48MP Main Camera',
      discount: 5,
      rating: 4.9,
      specifications: {
        'Display': '6.7" Super Retina XDR',
        'Processor': 'A17 Pro',
        'RAM': '8GB',
        'Storage': '256GB',
        'Camera': '48MP + 12MP + 12MP',
        'Battery': '4422mAh',
        'OS': 'iOS 17',
      },
      storeComparisons: [
        StoreComparison(
          storeName: 'Daraz',
          price: 195000,
          stock: 18,
          deliveryTime: '2-3 days',
          storeRating: 4.5,
          storeLink: 'https://www.daraz.com.bd',
          storeAddress: 'Dhaka, Bangladesh',
          storePhone: '09612422222',
          returnPolicy: '7 Days Return',
          warranty: '1 Year Warranty',
          isAvailable: true,
        ),
      ],
    ),
    Product(
      id: '3',
      name: 'Xiaomi TV 4K 55"',
      price: 54999,
      discountedPrice: 49999,
      stock: 67,
      category: 'Televisions',
      description: '4K UHD, Dolby Audio, Smart TV with PatchWall, MEMC Technology, Google Assistant',
      discount: 9,
      rating: 4.5,
      specifications: {
        'Display': '55" 4K UHD',
        'Resolution': '3840 x 2160',
        'Smart TV': 'Android TV',
        'Sound': 'Dolby Audio',
        'Ports': '3x HDMI, 2x USB',
        'Refresh Rate': '60Hz',
        'Warranty': '2 Years',
      },
      storeComparisons: [
        StoreComparison(
          storeName: 'Daraz',
          price: 51999,
          stock: 30,
          deliveryTime: '3-4 days',
          storeRating: 4.4,
          storeLink: 'https://www.daraz.com.bd',
          storeAddress: 'Dhaka, Bangladesh',
          storePhone: '09612422222',
          returnPolicy: '7 Days Return',
          warranty: '2 Years Warranty',
          isAvailable: true,
        ),
      ],
    ),
    Product(
      id: '4',
      name: 'Sony WH-1000XM5',
      price: 35999,
      discountedPrice: 32999,
      stock: 89,
      category: 'Headphones',
      description: 'Industry-leading noise cancellation, 30-hour battery life, Multipoint connection',
      discount: 8,
      rating: 4.7,
      specifications: {
        'Type': 'Over-ear Wireless',
        'Battery': '30 hours',
        'Noise Cancellation': 'Yes',
        'Bluetooth': '5.2',
        'Weight': '250g',
        'Charging': 'USB-C',
        'Warranty': '1 Year',
      },
      storeComparisons: [
        StoreComparison(
          storeName: 'Daraz',
          price: 33999,
          stock: 40,
          deliveryTime: '2-3 days',
          storeRating: 4.5,
          storeLink: 'https://www.daraz.com.bd',
          storeAddress: 'Dhaka, Bangladesh',
          storePhone: '09612422222',
          returnPolicy: '7 Days Return',
          warranty: '1 Year Warranty',
          isAvailable: true,
        ),
      ],
    ),
    Product(
      id: '5',
      name: 'Dell XPS 13',
      price: 129999,
      discountedPrice: 119999,
      stock: 32,
      category: 'Laptops',
      description: 'Intel Core i7, 16GB RAM, 512GB SSD, 13.4" 4K Touch Display, Windows 11 Pro',
      discount: 8,
      rating: 4.6,
      specifications: {
        'Processor': 'Intel Core i7',
        'RAM': '16GB',
        'Storage': '512GB SSD',
        'Display': '13.4" 4K Touch',
        'Graphics': 'Intel Iris Xe',
        'OS': 'Windows 11 Pro',
        'Weight': '1.2kg',
      },
      storeComparisons: [
        StoreComparison(
          storeName: 'Daraz',
          price: 125000,
          stock: 15,
          deliveryTime: '3-4 days',
          storeRating: 4.4,
          storeLink: 'https://www.daraz.com.bd',
          storeAddress: 'Dhaka, Bangladesh',
          storePhone: '09612422222',
          returnPolicy: '7 Days Return',
          warranty: '1 Year Warranty',
          isAvailable: true,
        ),
      ],
    ),
    Product(
      id: '6',
      name: 'Nike Air Max 270',
      price: 12999,
      discountedPrice: 10999,
      stock: 150,
      category: 'Shoes',
      description: 'Men Running Shoes with Max Air cushioning, Breathable mesh upper, Rubber outsole',
      discount: 15,
      rating: 4.4,
      specifications: {
        'Type': 'Running Shoes',
        'Material': 'Mesh & Synthetic',
        'Closure': 'Lace-up',
        'Cushion': 'Air Max',
        'Weight': '320g',
        'Colors': '6 Options',
        'Sizes': '7-12',
      },
      storeComparisons: [
        StoreComparison(
          storeName: 'Daraz',
          price: 11500,
          stock: 80,
          deliveryTime: '2-3 days',
          storeRating: 4.3,
          storeLink: 'https://www.daraz.com.bd',
          storeAddress: 'Dhaka, Bangladesh',
          storePhone: '09612422222',
          returnPolicy: '7 Days Return',
          warranty: 'No Warranty',
          isAvailable: true,
        ),
      ],
    ),
  ];

  final List<Order> kiLagbe= [
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
  ];

  String _searchQuery = '';

  List<Product> get filteredProducts {
    if (_searchQuery.isEmpty) {
      return _products;
    }
    return _products.where((product) {
      return product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _banners = [
    {'title': 'Mega Offer', 'subtitle': 'Up to 50% discount'},
    {'title': 'Free Delivery', 'subtitle': 'On orders above 5000৳'},
    {'title': 'Electronics Day', 'subtitle': 'Special prices'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToCart(Product product, {int quantity = 1}) {
    setState(() {
      final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);
      if (existingIndex >= 0) {
        // If product already exists, update quantity
        _cartItems[existingIndex].quantity += quantity;
      } else {
        // Add new product to cart
        _cartItems.add(CartItem(product: product, quantity: quantity));
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} ${quantity > 1 ? '($quantity)' : ''} added to cart'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _removeFromCart(CartItem cartItem) {
    setState(() {
      _cartItems.remove(cartItem);
    });
  }

  void _updateQuantity(CartItem cartItem, int newQuantity) {
    if (newQuantity < 1) return;
    
    setState(() {
      if (newQuantity == 0) {
        _cartItems.remove(cartItem);
      } else {
        cartItem.quantity = newQuantity;
      }
    });
  }

  void _updateProfile(UserProfile newProfile) {
    setState(() {
      _userProfile = newProfile;
    });
  }

  double get _cartTotal {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ki Lagbe',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your Favorite Shopping Partner',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        _onItemTapped(2);
                      },
                    ),
                    if (_cartItems.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            _cartItems.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {},
                      ),
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
            )
          : null,
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 2 && _cartItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                      cartItems: _cartItems,
                      total: _cartTotal,
                      onCheckoutComplete: () {
                        setState(() {
                          _cartItems.clear();
                        });
                      },
                    ),
                  )
                );
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Checkout'),
              backgroundColor: const Color(0xFF2E7D32),
            )
          : null,
    );
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return CategoryProductsPage(
          products: _products,
          onAddToCart: _addToCart,
        );
      case 2:
        return _buildCartPage();
      case 3:
        return _buildProfilePage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _banners.length,
                  itemBuilder: (context, index) {
                    final banner = _banners[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.green.shade800,
                                    Colors.green.shade400,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: -50,
                              bottom: -50,
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    banner['title'],
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    banner['subtitle'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      _onItemTapped(1); // Navigate to categories
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFF2E7D32),
                                    ),
                                    child: const Text('Shop Now'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _banners.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? const Color(0xFF2E7D32)
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _onItemTapped(1);
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryItem('Mobile', Icons.phone_android, Colors.blue, 'Mobile Phones'),
                _buildCategoryItem('Laptop', Icons.laptop, Colors.orange, 'Laptops'),
                _buildCategoryItem('TV', Icons.tv, Colors.purple, 'Televisions'),
                _buildCategoryItem('Headphones', Icons.headphones, Colors.red, 'Headphones'),
                _buildCategoryItem('Camera', Icons.camera, Colors.green, 'Cameras'),
                _buildCategoryItem('Home', Icons.home, Colors.brown, 'Home Appliances'),
                _buildCategoryItem('Fashion', Icons.shopping_bag, Colors.pink, 'Fashion'),
                _buildCategoryItem('Shoes', Icons.sports, Colors.teal, 'Shoes'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Best Deals',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color color, String category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsPage(
              products: _products,
              onAddToCart: _addToCart,
              selectedCategory: category,
            ),
          ),
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
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
              onAddToCart: () => _addToCart(product),
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      onPressed: () => _addToCart(product),
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

  Widget _buildCartPage() {
    if (_cartItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 30),
              Text(
                'Your Cart is Empty',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Looks like you haven\'t added any items to your cart yet.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Start shopping to add amazing products!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  _onItemTapped(0);
                },
                icon: const Icon(Icons.shopping_bag),
                label: const Text('Start Shopping'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  _onItemTapped(1);
                },
                icon: const Icon(Icons.category),
                label: const Text('Browse Categories'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2E7D32)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Cart (${_cartItems.length} items)',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear Cart'),
                      content: const Text('Are you sure you want to remove all items from your cart?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _cartItems.clear();
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cart cleared successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Clear All',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = _cartItems[index];
              final product = cartItem.product;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shopping_bag, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.category,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '৳${NumberFormat('#,##0').format(product.discountedPrice)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Quantity Controls
                      Column(
                        children: [
                          // Quantity Display
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                // Decrease Button
                                InkWell(
                                  onTap: () {
                                    if (cartItem.quantity > 1) {
                                      _updateQuantity(cartItem, cartItem.quantity - 1);
                                    } else {
                                      _removeFromCart(cartItem);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                // Quantity Display
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    cartItem.quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Increase Button
                                InkWell(
                                  onTap: () {
                                    if (cartItem.quantity < product.stock) {
                                      _updateQuantity(cartItem, cartItem.quantity + 1);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Only ${product.stock} items available in stock'),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Total for this item
                          Text(
                            '৳${NumberFormat('#,##0').format(cartItem.totalPrice)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // Remove Button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                        onPressed: () => _removeFromCart(cartItem),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal (${_cartItems.length} items)'),
                  Text('৳${NumberFormat('#,##0').format(_cartTotal)}'),
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
                  Text('৳${NumberFormat('#,##0').format(_cartTotal * 0.05)}'),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '৳${NumberFormat('#,##0').format(_cartTotal + 60 + (_cartTotal * 0.05))}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          cartItems: _cartItems,
                          total: _cartTotal,
                          onCheckoutComplete: () {
                            setState(() {
                              _cartItems.clear();
                            });
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  _onItemTapped(0);
                },
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade100,
                        border: Border.all(color: Colors.green.shade300, width: 3),
                        image: _userProfile.profileImageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(_userProfile.profileImageUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _userProfile.profileImageUrl == null
                          ? const Icon(Icons.person, size: 50, color: Colors.green)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  profile: _userProfile,
                                  onProfileUpdated: _updateProfile,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _userProfile.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(_userProfile.email),
                const SizedBox(height: 4),
                Text(_userProfile.phone),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          profile: _userProfile,
                          onProfileUpdated: _updateProfile,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade50,
                    foregroundColor: const Color(0xFF2E7D32),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: [
              _buildProfileOption(Icons.shopping_bag, 'My Orders', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ),
                );
              }),
              _buildProfileOption(Icons.location_on, 'Address', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditAddressPage(
                      profile: _userProfile,
                      onProfileUpdated: _updateProfile,
                    ),
                  ),
                );
              }),
              _buildProfileOption(Icons.payment, 'Payment Methods', () {}),
              _buildProfileOption(Icons.history, 'Order History', () {}),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Change theme'),
                value: false,
                onChanged: (value) {},
                secondary: const Icon(Icons.dark_mode),
              ),
              _buildProfileOption(Icons.notifications, 'Notifications', () {}),
              _buildProfileOption(Icons.security, 'Security', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecurityPage(),
                  ),
                );
              }),
              _buildProfileOption(Icons.language, 'Language', () {}),
              _buildProfileOption(Icons.help, 'Help & Support', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpSupportPage(),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Column(
            children: [
              _buildProfileOption(Icons.info, 'About Us', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              }),
              _buildProfileOption(Icons.share, 'Share App', () {}),
              _buildProfileOption(Icons.star, 'Rate App', () {}),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  _showLogoutDialog();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String title, Function onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => onTap(),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successfully logged out! Goodbye!'),
                  backgroundColor: Colors.green,
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthPage()),
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}