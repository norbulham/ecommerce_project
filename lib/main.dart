import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/binding/address_binding.dart';
import 'package:multi_ecommerce/pages/authentification/signUp.dart';
import 'package:multi_ecommerce/pages/authentification/sign_in.dart';
import 'package:multi_ecommerce/pages/cart_page.dart';
import 'package:multi_ecommerce/pages/home/address/add_address.dart';
import 'package:multi_ecommerce/pages/home/address/select_address.dart';
import 'package:multi_ecommerce/pages/home/ddd.dart';
import 'package:multi_ecommerce/pages/home/homepage.dart';
import 'package:multi_ecommerce/pages/home/payment/payment_page.dart';
import 'package:multi_ecommerce/pages/women/wishlist.dart';
import 'package:multi_ecommerce/pages/women/women_collection.dart';
import 'package:multi_ecommerce/pages/women/womenproduct_detail.dart';

import 'binding/cart_controller_binding.dart';
import 'binding/fav_controller_binding.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/sign_up',
      getPages: [
        GetPage(name: '/', page: () => Homepage()),
        GetPage(name: '/promo', page: () => PromoPage()),
        // GetPage(name: '/men_collection', page: () => MenCollection()),
        GetPage(
          name: '/women/detail',
          page: () => WomenProductDetail(),
          bindings: [FavControllerBinding(), CartControllerBinding()],
        ),
        GetPage(
          name: '/women_collection',
          page: () => WomenCollection(),
          bindings: [FavControllerBinding(), CartControllerBinding()],
        ),
        GetPage(
            name: '/wishlist',
            page: () => WishlistPage(),
            binding: FavControllerBinding()),
        GetPage(name: '/cart', page: () => CartPage()),
        GetPage(
          name: '/new/address',
          page: () => AddAddress(),
        ),
        GetPage(
            name: '/select_address',
            page: () => SelectAddress(),
            binding: SelectedAddressBinding()),
        GetPage(
            name: '/payment_page',
            page: () => PaymentPage(),
            binding: SelectedAddressBinding()),

        GetPage(
          name: '/siAgn_up',
          page: () => SignUp(),
        ),
        GetPage(
          name: '/sign_in',
          page: () => SignIn(),
        ),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
