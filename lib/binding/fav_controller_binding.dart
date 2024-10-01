import 'package:get/get.dart';
import '../manager/manage_whistlist.dart';

//
class FavControllerBinding with Bindings {
  @override
  void dependencies() {
    // Initialize CartController
    Get.lazyPut<WhistlistController>(() => WhistlistController());
  }
}
