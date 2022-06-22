import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class InitConfig {
  static init() async {
    await _initStorage();
    _setOrientation();
  }

  static _initStorage() async {
    await GetStorage.init();
  }

  static _setOrientation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
}
