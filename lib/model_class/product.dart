import 'package:get/get.dart';

class ProductModel {
  String id;
  String name;
  String category;
  String imgUrl;
  int newPrice;
  String oldPrice;
  String description;
  int quantity;

  ProductModel({
    required this.id,
    required this.quantity,
    required this.name,
    required this.category,
    required this.newPrice,
    required this.oldPrice,
    required this.imgUrl,
    required this.description,
  });

  // Convert a PlaceModel object into a Map object to send to Cloud,---->used when u want to create
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imgUrl': imgUrl,
      'newPrice': newPrice,
      'oldPrice': oldPrice,
      'quantity': quantity,
      'description': description,
    };
  }

  // Create a PlaceModel object from a Map object for fetching from Cloud\
// Convert the Map object to PlaceModel object
  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      newPrice: map['newPrice'] ?? '',
      oldPrice: map['oldPrice'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }
}
