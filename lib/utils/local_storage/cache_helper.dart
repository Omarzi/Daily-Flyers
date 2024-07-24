import 'dart:convert';

import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:daily_flyers_app/utils/constants/log_util.dart';

class DCacheHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static const String _cachedCode = "cachedCode";
  static const String _isDarkModeKey = "isDarkMode";

  static String getCachedLanguage() {
    final code = preferences?.getString(_cachedCode);
    if (code != null) {
      return code;
    } else {
      return 'en';
    }
  }

  static Future<void> cacheLanguage(String code) async {
    await preferences?.setString(_cachedCode, code);
  }

  static bool getIsDarkMode() {
    return preferences?.getBool(_isDarkModeKey) ?? false;
  }

  static Future<void> cacheIsDarkMode(bool isDarkMode) async {
    await preferences?.setBool(_isDarkModeKey, isDarkMode);
  }

  static Future<bool?> putString(
      {required CacheKeys key, required String value}) async {
    return await preferences?.setString(key.name, value);
  }

  static String? getString({
    required CacheKeys key,
  }) {
    return preferences?.getString(
      key.name,
    ) ??
        '';
  }

  static void putBoolean(
      {required CacheKeys key, required bool value}) async {
    await preferences?.setBool(key.name, value);
  }

  static bool getBoolean({
    required bool defaultValue,
    required CacheKeys key,
  }) {
    return preferences?.getBool(
      key.name,
    ) ??
        defaultValue;
  }

  static void putInt({required CacheKeys key, required int value}) async {
    await preferences?.setInt(key.name, value);
  }

  static int getInt({
    required CacheKeys key,
  }) {
    return preferences?.getInt(
      key.name,
    ) ??
        0;
  }

  static void putDouble(
      {required CacheKeys key, required double value}) async {
    await preferences?.setDouble(key.name, value);
  }

  static double getDouble({
    required CacheKeys key,
  }) {
    return preferences?.getDouble(
      key.name,
    ) ??
        0.0;
  }

  // Function to store a list of integers
  static Future<void> putIntList({
    required CacheKeys key,
    required List<int> value,
  }) async {
    String jsonString = jsonEncode(value);
    await preferences?.setString(key.name, jsonString);
  }

  // Function to retrieve a list of integers
  static Future<List<int>> getIntList({
    required CacheKeys key,
  }) async {
    String? jsonString = await preferences?.getString(key.name);
    logError(preferences!.getKeys().toString());
    if (jsonString == null) {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<int> intList = jsonList.cast<int>();
    return intList;
  }

  // Function to delete an item from a list of integers
  static Future<void> deleteIntListItem({
    required CacheKeys key,
    required int indexToDelete,
  }) async {
    List<int> intList = await getIntList(key: key);
    if (indexToDelete >= 0 && indexToDelete < intList.length) {
      intList.removeAt(indexToDelete);
      await putIntList(key: key, value: intList);
    }
  }

  static Future<void> removeFromShared({
    required CacheKeys key,
  }) async {
    await preferences?.remove(key.name);
  }

  static Future<void> clearShared() async {
    await preferences?.clear();
  }
}