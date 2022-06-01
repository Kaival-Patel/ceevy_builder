import 'package:get_storage/get_storage.dart';

class InitConfig {
  static init() async {
    await _initStorage();
  }

  static _initStorage() async {
    await GetStorage.init();
  }
}
