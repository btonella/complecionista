import 'package:complecionista/common/infra/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPreferences {
  late FlutterSecureStorage storage;

  AppPreferences() {
    getInstances();
  }

  void getInstances() {
    AndroidOptions androidOptions = const AndroidOptions(encryptedSharedPreferences: true);
    IOSOptions iosOptions = const IOSOptions();
    storage = FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  }

  Future<User> getUser() async {
    String? resp = await storage.read(key: "user");
    if (resp == null || resp.isEmpty) return User();
    return User.fromJson(resp);
  }

  Future<bool> saveUser(User user) async {
    bool isSuccess = true;
    try {
      await storage.write(key: "user", value: user.toJson());
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<bool> saveToken(String token) async {
    bool isSuccess = true;
    try {
      await storage.write(key: "token", value: token);
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<String> getToken() async {
    String token = await storage.read(key: "token") ?? "";
    return token;
  }

  Future<void> logout() async {
    await storage.delete(key: 'user');
    await storage.delete(key: 'token');
  }

  Future<bool> saveRememberUser(String rememberUser) async {
    bool isSuccess = true;
    try {
      await storage.write(key: "rememberUser", value: rememberUser);
    } catch (e) {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<String> getRememberUser() async {
    String resp = await storage.read(key: "rememberUser") ?? '';
    return resp;
  }
}
