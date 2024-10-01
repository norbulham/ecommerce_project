// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
// import 'package:gap/gap.dart';
// import 'package:multi_ecommerce/constant/color_constraint.dart';
// import 'package:multi_ecommerce/widgets/sub_text.dart';
// import 'package:get/get.dart';
// import 'package:badges/badges.dart' as badges;
// import '../../manager/manage_product.dart';
// import '../../manager/manage_whistlist.dart';
// import '../model_class/product.dart';
//
// class WomenCollection extends StatelessWidget {
//   final CartController cartController = Get.find<CartController>();
//   final WhistlistController favController = Get.find<WhistlistController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() {
//           // Using Obx to reactively update the title based on the wishlist count
//           int productCount = favController.favItems.length;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               RegularText(
//                 text: 'Women Collection',
//                 fontSize: 20,
//               ),
//               RegularText(
//                 text: '$productCount Products',
//                 color: AppColors.grey,
//               ),
//             ],
//           );
//         }),
//         actions: [
//           // Wishlist Badge
//           Obx(() => badges.Badge(
//             position: badges.BadgePosition.topEnd(top: -13, end: -8),
//             badgeContent: Text(favController.totalItems.toString()),
//             child: Icon(Icons.favorite),
//           )),
//           const Gap(16),
//           // Cart Badge
//           Obx(() => badges.Badge(
//             position: badges.BadgePosition.topEnd(top: -13, end: -8),
//             badgeContent: Text(cartController.totalItems.toString()),
//             child: Icon(Icons.shopping_bag),
//           )),
//           const SizedBox(width: 16),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Column(
//           children: [
//             // Search bar and filter button
//             Row(
//               children: [
//                 Expanded(
//                   flex: 6,
//                   child: Material(
//                     elevation: 2.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: Container(
//                       height: 50,
//                       padding: const EdgeInsets.only(left: 10),
//                       decoration: BoxDecoration(color: AppColors.lightGrey),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.search_rounded,
//                             color: AppColors.grey,
//                             size: 30,
//                           ),
//                           const Gap(20),
//                           Expanded(
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: 'Search',
//                                 hintStyle: TextStyle(
//                                   color: AppColors.grey,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Gap(10),
//                 Expanded(
//                   flex: 1,
//                   child: Material(
//                     elevation: 2,
//                     borderRadius: BorderRadius.circular(10),
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: AppColors.primary,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Icon(Icons.filter_list, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(20),
//             // Product Grid
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('products')
//                     .where('category', isEqualTo: 'women')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text('No products found'));
//                   }
//
//                   final products = snapshot.data!.docs.map((doc) {
//                     return Product.fromFirestore(doc);
//                   }).toList();
//
//                   return GridView.builder(
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               alignment: Alignment.topRight,
//                               children: [
//                                 Container(
//                                   height: 200,
//                                   width: 170,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: AppColors.lightGrey,
//                                     image: DecorationImage(
//                                       image: NetworkImage(product.imgUrl),
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Obx(() {
//                                     bool isInWishlist = favController
//                                         .isInWishlist(product.id);
//                                     return GestureDetector(
//                                       onTap: () {
//                                         favController.toggleWishlist(
//                                             product.id, product.toMap());
//                                         Get.snackbar(
//                                           isInWishlist ? 'Removed' : 'Success',
//                                           isInWishlist
//                                               ? 'Product removed from wishlist'
//                                               : 'Product added to wishlist',
//                                           snackPosition: SnackPosition.BOTTOM,
//                                           backgroundColor: isInWishlist
//                                               ? Colors.red
//                                               : Colors.green,
//                                           colorText: Colors.white,
//                                           duration: const Duration(seconds: 2),
//                                         );
//                                       },
//                                       child: Icon(
//                                         isInWishlist
//                                             ? Icons.favorite
//                                             : Icons.favorite_border,
//                                         color: isInWishlist
//                                             ? Colors.red
//                                             : AppColors.grey,
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ],
//                             ),
//                             const Gap(10),
//                             PannableRatingBar(
//                               rate: 3, // Example rating value
//                               items: List.generate(
//                                 5,
//                                     (index) => const RatingWidget(
//                                   selectedColor: Colors.yellow,
//                                   unSelectedColor: Colors.grey,
//                                   child: Icon(
//                                     Icons.star,
//                                     size: 24,
//                                   ),
//                                 ),
//                               ),
//                               onChanged: (value) {
//                                 // Handle rating change
//                               },
//                             ),
//                             const Gap(10),
//                             Text(
//                               product.name,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               '\$${product.newPrice}',
//                               style: const TextStyle(color: Colors.green),
//                             ),
//                             if (product.oldPrice > 0)
//                               Text(
//                                 '\$${product.oldPrice}',
//                                 style: const TextStyle(
//                                   color: Colors.red,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       );
//                     },
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       childAspectRatio: 0.55, // Adjusted aspect ratio for better fit
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
