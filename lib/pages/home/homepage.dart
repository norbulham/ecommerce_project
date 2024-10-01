import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/model_class/product.dart';
import 'package:multi_ecommerce/pages/home/product_body.dart';
import 'package:multi_ecommerce/pages/home/slider.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../services/product_services.dart';

class Homepage extends StatefulWidget {
  // final String category;
  Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double rating = 0.0;
  // final category = widget.category;
  final ProductServices _services = ProductServices();
  // final CollectionReference products =
  //     FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.menu_open)),
              // Add logo here
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notification_add_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_rounded)),
            Gap(14),
          ],
        ),
        body: Column(
          children: [
            // Fixed Category Section
            SizedBox(
              height: 120.0,
              child: StreamBuilder<List<ProductModel>>(
                stream: _services.fetchMenCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data;
                  if (products == null || products.isEmpty) {
                    print('No products found');
                    return Center(
                        child: Text('No products found in this category.'));
                  } else {
                    print('Products: ${products.map((e) => e.name).toList()}');
                    return ListView.builder(
                      itemCount: products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  Image.network(
                                    '${product.imgUrl}',
                                    height: 70,
                                    width: 65,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ],
                              ),
                              Text('${product.category}'),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //---add slider here
                      ImageSlider(),
                      Gap(20),
                      //---product listing
                      ProductBody(),
                      //--timer
                      Gap(20),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 160.0,
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                BoxDecoration(color: AppColors.lightGrey),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RegularText(
                                      text: 'Denim Wear',
                                      color: Colors.grey.shade500,
                                      fontSize: 20,
                                    ),
                                    Gap(10),
                                    Container(
                                      height: 30, // Adjust the height as needed
                                      child: SlideCountdownSeparated(
                                        duration: Duration(
                                            hours: 1, minutes: 30, seconds: 45),
                                        style: TextStyle(
                                          fontSize: 18, // Adjust font size
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // Adjust padding
                                        onDone: () {
                                          Get.snackbar(
                                              '', 'Countdown completed',
                                              backgroundColor:
                                                  AppColors.lightGrey);
                                        },
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: Material(
                                        elevation: 5.0,
                                        borderRadius: BorderRadius.circular(10),
                                        child: TextButton(
                                            onPressed: () {},
                                            child: RegularText(
                                              text: 'Explore Now',
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -25,
                            right: -10,
                            child: Container(
                                margin: EdgeInsets.only(left: 150),
                                height: 220,
                                width: 190,
                                child: Image.asset(
                                    fit: BoxFit.fitWidth,
                                    'assets/images/pngegg (1).png')),
                          )
                        ],
                      ),
                      Gap(40),
                      RegularText(text: 'Biggest Deals on Top Brands'),
                      Gap(20),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/addidas.png'),
                            )),
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/puma.png'),
                            )),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/reebook.png'),
                            )),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/images/nike.png'),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Gap(40),
                      //-----------kid's corner
                      RegularText(text: 'The Kids Corner'),
                      RegularText(
                        text: 'Clothing for your Li\'l One\'s',
                        color: AppColors.grey,
                      ),
                      Gap(20),
                      SizedBox(
                        height: 300,
                        child: StreamBuilder<List<ProductModel>>(
                          stream: _services.fetchKidsCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return RegularText(text: 'Something Went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final products = snapshot.data!;

                            if (products.length == 0) {
                              return Center(
                                  child: Text(
                                      'No products found in this category.'));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];

                                  // // Safely access product data
                                  // final String imgUrl =
                                  //     product['imgUrl'] ?? 'default_image_url';
                                  // final String name =
                                  //     product['name'] ?? 'Unknown Product';
                                  // final double newPrice =
                                  //     (product['newPrice'] as num?)
                                  //             ?.toDouble() ??
                                  //         0.0;
                                  // final double oldPrice =
                                  //     (product['oldPrice'] as num?)
                                  //             ?.toDouble() ??
                                  //         0.0;

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              height: 200,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.lightGrey,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${product.imgUrl}'), // Use NetworkImage for URL images
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.favorite,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        PannableRatingBar(
                                          rate: rating,
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
                                            setState(() {
                                              rating = value;
                                            });
                                          },
                                        ),
                                        RegularText(
                                          text: '${product.name}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            RegularText(
                                                text: '\$${product.newPrice}'),
                                            const Gap(20),
                                            RegularText(
                                              text: '\$${product.oldPrice}',
                                              line: TextDecoration.lineThrough,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
