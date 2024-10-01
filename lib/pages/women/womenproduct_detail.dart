import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../../constant/color_constraint.dart';
import '../../../manager/manage_product.dart';
import '../../../manager/manage_whistlist.dart';
import '../../../model_class/product.dart';
import '../../../widgets/color_variant.dart';
import '../../../widgets/sub_text.dart';

class WomenProductDetail extends StatelessWidget {
  WomenProductDetail({super.key});

  final CartController cartController = Get.find<CartController>();
  final WhistlistController favController = Get.find<WhistlistController>();

  // Add a variable to keep track of the selected size
  RxString selectedSize = 'S'.obs;

  @override
  Widget build(BuildContext context) {
    final ProductModel? product = Get.arguments as ProductModel?;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Product not found'),
        ),
      );
    }

    // Debugging: Check product data
    print('Product Details: ${product.toMap()}');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: RegularText(
                text: product.name,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Icon(Icons.share_rounded, size: 30),
          Gap(15),
          Obx(() => badges.Badge(
                position: badges.BadgePosition.topEnd(top: -13, end: -8),
                badgeContent: RegularText(
                  text: favController.totalItems.toString(),
                  color: AppColors.lightGrey,
                ),
                child: Icon(Icons.favorite, size: 30),
              )),
          Gap(15),
          Obx(() => InkWell(
                onTap: () {
                  Get.toNamed('/cart');
                },
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -13, end: -8),
                  badgeContent: RegularText(
                    text: cartController.totalItems.toString(),
                    color: AppColors.lightGrey,
                  ),
                  child: Icon(Icons.shopping_cart, size: 30),
                ),
              )),
          Gap(20),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and color variant section
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage('${product.imgUrl}'))),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Column(
                      children: [
                        CircularColorVariant(clr: Colors.red),
                        Gap(10),
                        CircularColorVariant(clr: Colors.blue),
                        Gap(10),
                        CircularColorVariant(clr: Colors.yellow),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(30),
              // Product Details Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegularText(
                        text: '${product.name}',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      RegularText(
                        text: '\$${product.newPrice}.00',
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PannableRatingBar(
                        rate: 3,
                        items: List.generate(
                          5,
                          (index) => const RatingWidget(
                            selectedColor: Colors.yellow,
                            unSelectedColor: Colors.grey,
                            child: Icon(
                              Icons.star,
                              size: 24,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle rating change
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          favController.toggleWishlist(
                              product.id, product.toMap());
                          if (favController.isInWishlist(product.id)) {
                            Get.snackbar(
                              'Success',
                              'Product added to wishlist',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          } else {
                            Get.snackbar(
                              'Removed',
                              'Product removed from wishlist',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                          }
                        },
                        child: Obx(() => GestureDetector(
                              onTap: () {
                                favController.toggleWishlist(
                                    product.id, product.toMap());
                                if (favController.isInWishlist(product.id)) {
                                  Get.snackbar(
                                    'Success',
                                    'Product added to wishlist',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                } else {
                                  Get.snackbar(
                                    'Removed',
                                    'Product removed from wishlist',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                }
                              },
                              child: Icon(
                                favController.isInWishlist(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favController.isInWishlist(product.id)
                                    ? Colors.red
                                    : AppColors.grey,
                                size: 35,
                              ),
                            )),
                      ),
                    ],
                  ),
                  Gap(20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cartController.incrementQuantity(product);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightGrey),
                          child: Center(
                            child: Icon(Icons.add, color: AppColors.grey),
                          ),
                        ),
                      ),
                      Gap(20),
                      GetBuilder<CartController>(builder: (_) {
                        return RegularText(
                          text: '${product.quantity}', // Access the RxInt value
                          fontWeight: FontWeight.w700,
                          color: AppColors.grey,
                        );
                      }),
                      Gap(20),
                      GestureDetector(
                        onTap: () {
                          cartController.decrementQuantity(product);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightGrey),
                          child: Center(
                            child: Icon(Icons.remove, color: AppColors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  RegularText(
                    text: 'Select Size',
                    fontWeight: FontWeight.w700,
                    color: AppColors.grey,
                    fontSize: 20,
                  ),
                  Gap(10),
                  Row(
                    children: [
                      buildSizeOption('S'),
                      Gap(10),
                      buildSizeOption('M'),
                      Gap(10),
                      buildSizeOption('L'),
                      Gap(10),
                      buildSizeOption('XL'),
                      Gap(10),
                      buildSizeOption('XXL'),
                    ],
                  ),
                  Gap(20),
                  RegularText(
                    text: 'Description',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  Gap(10),
                  RegularText(text: '${product.description}'),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      bool added = cartController.addToCart(product);
                      if (added) {
                        Get.snackbar(
                          'Added to Cart',
                          'Product added to cart successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blue,
                          colorText: Colors.white,
                          duration: Duration(seconds: 2),
                        );
                      } else {
                        Get.snackbar(
                          'Product exist',
                          'Product is already in the cart',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blue,
                          colorText: Colors.white,
                          duration: Duration(seconds: 2),
                        );
                      }
                    },
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: RegularText(
                            text: 'Add to Cart',
                            color: AppColors.lightGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSizeOption(String size) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: size == 'S'
            ? Colors.red.withOpacity(0.4)
            : Colors.red.withOpacity(0.1),
      ),
      child: Center(
        child: RegularText(
          text: size,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
