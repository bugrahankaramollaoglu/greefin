class Purchase {
  final String id;
  final String name;
  final DateTime? date;
  final String category;
  final double price;

  Purchase(
      {required this.id,
      required this.name,
      required this.date,
      required this.category,
      required this.price});
}
