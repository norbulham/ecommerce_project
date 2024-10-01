import 'package:get/get.dart';
import '../model_class/address_model.dart';

class SelectedAddressController extends GetxController {
  AddressModel? selectedAddress;

  // Track the selection state
  bool _isSelected = false;

  // Select an address and toggle selection state
  void selectAddress(AddressModel address) {
    selectedAddress = address;
    _toggleSelection();
    update(); // Notify listeners to rebuild the UI if necessary
  }

  // Get the currently selected address
  AddressModel? getSelectedAddress() {
    return selectedAddress;
  }

  // Public method to get the current selection state
  bool isSelected(AddressModel address) {
    return _isSelected;
  }

  // Toggle the selection state and update the UI
  void _toggleSelection() {
    //
    _isSelected = !_isSelected;
    update(); // Notify listeners to rebuild the UI if necessary
  }
}
