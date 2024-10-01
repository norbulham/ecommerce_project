import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import '../../manager/manage_whistlist.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WhistlistController favController = Get.find<WhistlistController>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RegularText(
              text: 'Your Wishlist',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Obx(() => RegularText(
                  text: '${favController.favItems.length}',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                )),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<WhistlistController>(
                builder: (_) {
                  return ListView.builder(
                    itemCount: favController.favItems.length,
                    itemBuilder: (context, index) {
                      final item = favController.favItems[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightGrey,
                                    image: DecorationImage(
                                      image: NetworkImage(item['imgUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RegularText(
                                          text: item['name'],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        Gap(5),
                                        RegularText(
                                          text: 'by ${item['brand']}',
                                          fontSize: 14,
                                          // color: Colors.grey[600],
                                        ),
                                        Gap(10),
                                        RegularText(
                                          text: '\$${item['newPrice']}',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(() => GestureDetector(
                                      onTap: () {
                                        favController.toggleWishlist(
                                            item['id'], item.toMap());
                                        if (favController
                                            .isInWishlist(item['id'])) {
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
                                        favController.isInWishlist(item['id'])
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: favController
                                                .isInWishlist(item['id'])
                                            ? Colors.red
                                            : AppColors.grey,
                                      ),
                                    )),
                                IconButton(
                                  icon: Icon(Icons.add_shopping_cart,
                                      color: Colors.green),
                                  onPressed: () {
                                    // Add to cart logic here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Added to Cart',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
