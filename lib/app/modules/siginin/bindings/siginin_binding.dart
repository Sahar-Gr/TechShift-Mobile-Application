import 'package:get/get.dart';

import '../controllers/siginin_controller.dart';

class SigininBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigininController>(
      () => SigininController(),
    );
  }
}
