import 'package:shared_preferences/shared_preferences.dart';

Future<void> setIsOpened(String key, bool value) async {
  final openedInfo = await SharedPreferences.getInstance();
  await openedInfo.setBool(key, value);
}

Future<bool?> loadIsOpened(String key) async {
  final openedInfo = await SharedPreferences.getInstance();
  return openedInfo.getBool(key);
}
