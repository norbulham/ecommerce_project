import 'package:get/get.dart';

import '../manager/manage_product.dart';

class CartControllerBinding with Bindings {
  @override
  void dependencies() {
    // Initialize CartController
    Get.lazyPut<CartController>(() => CartController());
  }
}
