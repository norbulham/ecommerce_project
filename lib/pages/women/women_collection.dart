import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shimmer/shimmer.dart';

import '../../../constant/color_constraint.dart';
import '../../../manager/manage_product.dart';
import '../../../manager/manage_whistlist.dart';
import '../../../model_class/product.dart';
import '../../../services/product_services.dart';
import '../../../widgets/sub_text.dart';

class WomenCollection extends StatelessWidget {
  final ProductServices _services = ProductServices();
  final CartController cartController = Get.find<CartController>();
  final WhistlistController favController = Get.find<WhistlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<List<ProductModel>>(
          stream: _services.fetchWomenProduct(),
          builder: (context, snapshot) {
            int productCount = 0;
            if (snapshot.hasData && snapshot.data != null) {
              productCount = snapshot.data!.length;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(text: 'Women Collection', fontSize: 20),
                RegularText(
                    text: '$productCount Products', color: AppColors.grey),
              ],
            );
          },
        ),
        actions: [
          Obx(() => badges.Badge(
                position: badges.BadgePosition.topEnd(top: -13, end: -8),
                badgeContent: Text(favController.totalItems.toString()),
                child: Icon(Icons.favorite),
              )),
          const Gap(16),
          Obx(() => badges.Badge(
                position: badges.BadgePosition.topEnd(top: -13, end: -8),
                badgeContent: Text(cartController.totalItems.toString()),
                child: Icon(Icons.shopping_bag),
              )),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Search bar and other widgets
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(color: AppColors.lightGrey),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: AppColors.grey,
                              size: 30,
                            ),
                            const Gap(20),
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      color: AppColors.grey, fontSize: 18)),
                            )),
                          ],
                        ),
                      ),
                    )),
                const Gap(10),
                Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.filter_list, color: Colors.white),
                      ),
                    )),
              ],
            ),
            const Gap(20),
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: _services.fetchWomenProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Shimmer effect while loading
                    return GridView.builder(
                      itemCount: 6, // Number of shimmer items
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            period: Duration(seconds: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                ),
                                const Gap(10),
                                Container(
                                  height: 15,
                                  width: 100,
                                  color: Colors.grey[300],
                                ),
                                const Gap(5),
                                Container(
                                  height: 15,
                                  width: 60,
                                  color: Colors.grey[300],
                                ),
                                const Gap(5),
                                Container(
                                  height: 15,
                                  width: 50,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.45,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No products found'));
                  }

                  final products = snapshot.data!;

                  return GridView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/women/detail',
                                    arguments: product);
                              },
                              child: Container(
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.lightGrey,
                                        image: DecorationImage(
                                          image: NetworkImage(product.imgUrl),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(() => GestureDetector(
                                            onTap: () {
                                              favController.toggleWishlist(
                                                  product.id, product.toMap());
                                              if (favController
                                                  .isInWishlist(product.id)) {
                                                Get.snackbar(
                                                  'Success',
                                                  'Product added to wishlist',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white,
                                                  duration:
                                                      Duration(seconds: 2),
                                                );
                                              } else {
                                                Get.snackbar(
                                                  'Removed',
                                                  'Product removed from wishlist',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white,
                                                  duration:
                                                      Duration(seconds: 2),
                                                );
                                              }
                                            },
                                            child: Icon(
                                              favController
                                                      .isInWishlist(product.id)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: favController
                                                      .isInWishlist(product.id)
                                                  ? Colors.red
                                                  : AppColors.grey,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10),
                            PannableRatingBar(
                              rate: 3, // Example rating value
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
                            const Gap(10),
                            Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${product.newPrice}',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              '\$${product.oldPrice}',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.45,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
