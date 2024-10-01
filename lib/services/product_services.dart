import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_ecommerce/model_class/product.dart';

class ProductServices {
  Stream<List<ProductModel>> fetchWomenProduct() {
    return FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'women')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<ProductModel>> fetchMenCategory() {
    return FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'men')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<ProductModel>> fetchKidsCategory() {
    return FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'kids')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<ProductModel>> fetchProduct() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({'quantity': newQuantity});
  }
}
