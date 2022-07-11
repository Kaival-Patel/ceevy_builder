import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
var versionRepo = Get.put(VerisonRepo(),permanent: true);
class VerisonRepo extends GetxController {
  RxString version = "Version : ".obs;

  @override
  void onInit() {
    super.onInit();
    initPackageInfo();
  }

  initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version('Version : '+packageInfo.version + ":" + packageInfo.buildNumber);
  }
}
