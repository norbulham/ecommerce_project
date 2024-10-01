import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';

import '../../widgets/main_text.dart';

//you can create modal class for this
class ImageSlider extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/New Product.png',
    'assets/images/products/dress2.jpeg',
    'assets/images/products/pants2.jpeg',
  ];

  //do design for the banner

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 900),
        viewportFraction: 0.8,
      ),
      items: imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.lightGrey,
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SemiBoldText(
                        text: 'Welcome To ShoppyCart',
                      ),
                      Text('Welcome'),
                      Text('Welcome'),
                      Text('Welcome'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
