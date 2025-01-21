import 'package:get/get.dart';
import 'network_connection_services.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkConnectionController>(NetworkConnectionController(),permanent: true);
  }
}