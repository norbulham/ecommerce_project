import 'package:get/get.dart';
import 'package:multi_ecommerce/manager/manage_address.dart';

class SelectedAddressBinding with Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedAddressController>(() => SelectedAddressController());
  }
}
