import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/model/purchase.dart';
import 'package:greefin/view_model/purchase_model.dart';

class MainPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(purchaseProvider);

    return Scaffold();
  }
}
