import 'package:get/get.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {

    /// custom Controller
    // Get.lazyPut(() => HomeController(), fenix: true);
  }

}