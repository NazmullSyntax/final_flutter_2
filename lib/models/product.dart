import 'store_comparison.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final double discountedPrice;
  final int stock;
  final String category;
  final String description;
  final int discount;
  final double rating;
  final Map<String, String> specifications;
  final List<StoreComparison> storeComparisons;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountedPrice,
    required this.stock,
    required this.category,
    required this.description,
    required this.discount,
    required this.rating,
    this.specifications = const {},
    this.storeComparisons = const [],
  });
}