import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/model_class/product.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';

import '../../services/product_services.dart';
import '../../widgets/main_text.dart';

class ProductBody extends StatelessWidget {
  ProductBody({super.key});

  //calling instance of a products from fireBase

  @override
  Widget build(BuildContext context) {
    final ProductServices _services = ProductServices();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SemiBoldText(
              text: 'Deals of the day',
            ),
            RegularText(
              text: 'See All',
              color: AppColors.primary,
            ),
          ],
        ),
        Gap(20),
        StreamBuilder<List<ProductModel>>(
            stream: _services.fetchProduct(),
            builder: (context, snapshot) {
              final products = snapshot.data!;
              if (snapshot.hasError) {
                return RegularText(text: 'Something Went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final data = snapshot.requireData;
              return ListView.builder(
                shrinkWrap:
                    true, // Allows the ListView to be as small as possible
                physics:
                    NeverScrollableScrollPhysics(), // Disables scrolling for this ListView
                itemCount: products.length > 6 ? 6 : products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightGrey,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage('${product.imgUrl}'))),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              isThreeLine: true,
                              horizontalTitleGap: 20.0,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SemiBoldText(
                                    text: '${product.name}',
                                  ),
                                  SemiBoldText(
                                    text: 'by Mango',
                                    color: AppColors.grey,
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  SemiBoldText(
                                    text: '\$${product.newPrice}',
                                  ),
                                  Gap(5),
                                  SemiBoldText(
                                    text: '\$${product.oldPrice}',
                                  ),
                                  Gap(5),
                                  RegularText(
                                    text: '20%',
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.favorite,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            })
      ],
    );
  }
}
