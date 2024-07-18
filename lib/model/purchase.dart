class Purchase {
  final String user; // Store the logged-in email
  final String name;
  final DateTime? date;
  final String category;
  final double price;

  Purchase({
    required this.user,
    required this.name,
    required this.date,
    required this.category,
    required this.price,
  });

  @override
  String toString() {
    return 'Purchase{user: $user, name: $name, date: $date, category: $category, price: $price}';
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'name': name,
      'date': date?.toIso8601String(),
      'category': category,
      'price': price,
    };
  }
}
