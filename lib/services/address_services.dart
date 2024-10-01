import 'package:cloud_firestore/cloud_firestore.dart';
import '../model_class/address_model.dart';

class AddressServices {
  Future<void> addAddress(AddressModel address) async {
    final docRef =
        FirebaseFirestore.instance.collection('delivery_address').doc();
    address.id = docRef.id;
    await docRef.set(address.toMap());
  }

  Stream<List<AddressModel>> fetchAddress() {
    return FirebaseFirestore.instance
        .collection('delivery_address')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AddressModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateAddress(AddressModel address) async {
    final docRef = FirebaseFirestore.instance
        .collection('delivery_address')
        .doc(address.id);
    await docRef.update(address.toMap());
  }

  // Future<void> deleteBook(String bookId) async {
  //   final docRef = FirebaseFirestore.instance.collection('book').doc(bookId);
  //   await docRef.delete();
  // }
}

// class EmployeeServices {
//   Future addEmployeeDetails(
//       Map<String, dynamic> employeeInfoMap, String id) async {
//     return await FirebaseFirestore.instance
//         .collection('Employee')
//         .doc(id)
//         .set(employeeInfoMap);
//   }
//
//   Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
//     return await FirebaseFirestore.instance.collection('Employee').snapshots();
//   }
//
//   Future updateEmployee(String id, Map<String, dynamic> updateInfoMap) async {
//     return await FirebaseFirestore.instance
//         .collection('Employee')
//         .doc(id)
//         .update(updateInfoMap);
//   }
//
//   Future deleteEmployee(
//     String id,
//   ) async {
//     return await FirebaseFirestore.instance
//         .collection('Employee')
//         .doc(id)
//         .delete();
//   }
// }
