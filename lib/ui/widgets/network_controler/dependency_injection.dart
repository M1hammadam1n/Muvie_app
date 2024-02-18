import 'package:get/get.dart';
import 'package:move_app_1/ui/widgets/network_controler/network_controler.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
