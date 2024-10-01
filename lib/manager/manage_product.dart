import 'package:get/get.dart';
import 'package:multi_ecommerce/model_class/product.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs; // Observable list of products
  var totalPrice = 0.0.obs; // Observable for the total price

  bool addToCart(ProductModel product) {
    if (product.id == null) {
      print('Product does not have an ID');
      return false; // Indicate failure to add product
    }

    bool exists = cartItems.any((item) => item.id == product.id);

    if (!exists) {
      // Initialize quantity when adding the product
      cartItems.add(
          product); // Adds to cart and automatically updates the UI// Update total price when a new product is added
      return true; // Product added successfully
    } else {
      return false; // Product already exists
    }
  }

  void removeFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.id == product.id);
    update();
    // Update total price when a product is removed
  }

  int get totalItems => cartItems.length;

  void incrementQuantity(ProductModel product) {
    product.quantity++;
    update();
  }

  void decrementQuantity(ProductModel product) {
    if (product.quantity > 0) {
      product.quantity--;
      update();
    }
  }

  double getTotalPrice() {
    return cartItems.fold(0, (total, item) {
      return total + (item.newPrice * item.quantity);
    });
  }

  // void incrementQuantity(ProductModel product) {
  //   int index = cartItems.indexWhere((item) => item.id == product.id);
  //   if (index != -1) {
  //     cartItems[index].quantity += 1;
  //     update(); // This is important to update the UI
  //   }
  // }
  //
  // void decrementQuantity(ProductModel product) {
  //   int index = cartItems.indexWhere((item) => item.id == product.id);
  //   if (index != -1 && cartItems[index].quantity > 1) {
  //     cartItems[index].quantity -= 1;
  //     update(); // This is important to update the UI
  //   }
  // }
}
