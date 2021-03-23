import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

  Future readSecureData(key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }

  Future readAllSecureData() async {
    var allData = await _storage.readAll();
    return allData;
  }

  Future deleteSecureData(key) async {
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}
