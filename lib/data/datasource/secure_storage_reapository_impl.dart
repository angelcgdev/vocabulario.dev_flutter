import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vocabulario_dev/domain/repository/secure_storage_reapository.dart';

class SecureStorageReapositoryImpl
    implements SecureStorageReapositoryInterface {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }

  @override
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }
}
