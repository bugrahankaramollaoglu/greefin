import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/model/purchase.dart';

class PurchaseViewModel extends StateNotifier<Purchase> {
  PurchaseViewModel()
      : super(Purchase(user: '', name: '', date: null, category: '', price: 0.0));

  void updatePurchase(
      String user, String name, DateTime? date, String category, double price) {
    state = Purchase(
        user: user, name: name, date: date, category: category, price: price);
  }
}

final purchaseProvider =
    StateNotifierProvider<PurchaseViewModel, Purchase>((ref) {
  return PurchaseViewModel();
});
