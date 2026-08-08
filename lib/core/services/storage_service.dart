import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Provider for StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

/// StorageService provides generic key-value storage using Hive.
class StorageService {
  static const String _boxName = 'app_data_box';
  Box? _box;

  /// Initializes Hive storage. Should be called in main.dart
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  Future<void> writeData(String key, dynamic value) async {
    if (_box == null) await init();
    await _box!.put(key, value);
  }

  Future<dynamic> readData(String key, {dynamic defaultValue}) async {
    if (_box == null) await init();
    return _box!.get(key, defaultValue: defaultValue);
  }

  Future<void> deleteData(String key) async {
    if (_box == null) await init();
    await _box!.delete(key);
  }

  Future<void> clearAll() async {
    if (_box == null) await init();
    await _box!.clear();
  }
}
