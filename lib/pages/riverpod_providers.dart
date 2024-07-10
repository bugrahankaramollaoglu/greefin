import 'package:flutter_riverpod/flutter_riverpod.dart';

final showRegisterProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);

final showForgotPasswdProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);
