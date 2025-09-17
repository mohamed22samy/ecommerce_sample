
import 'package:ecommerce_sample/core/services/storage_service/storage_operations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServiceImpl implements StorageOperations {
  final FlutterSecureStorage _storage;

  StorageServiceImpl(this._storage);

  @override
  Future<String> read(String key) async {
    return await _storage.read(key: key) ?? '';
  }

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
