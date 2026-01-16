class Order {
  final String id;
  final DateTime date;
  final double total;
  final String status;
  final int items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
  });
}