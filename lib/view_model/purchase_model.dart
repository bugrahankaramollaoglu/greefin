import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/model/purchase.dart';

class PurchaseViewModel extends StateNotifier<Purchase> {
  PurchaseViewModel()
      : super(Purchase(id: '', name: '', date: null, category: '', price: 0.0));

  void updatePurchase(
      String id, String name, DateTime? date, String category, double price) {
    state = Purchase(
        id: id, name: name, date: date, category: category, price: price);
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseViewModel, Purchase>((ref) {
  return PurchaseViewModel();
});
