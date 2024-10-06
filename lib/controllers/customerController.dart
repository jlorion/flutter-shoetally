import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce_mobile/models/CustomersModel.dart';

class CustomerController {
  Future<void> addCustomer(Customers customer) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('customers');

    DocumentReference docRef = await collection.add(customer.toJson());

    // Update the document to include the auto-generated ID as a field
    await docRef.update({
      'id': docRef.id, // Save the auto-generated ID to a field named 'id'
    });
  }

  Future<List<Customers>> getAllCustomers() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('customers').get();

    return snapshot.docs
        .map((doc) => Customers.fromFireStore(doc.data(), doc.id))
        .toList();
  }

  Future<void> editCustomer(Customers customer) async {
    final docCustomer =
        FirebaseFirestore.instance.collection('customers').doc(customer.id);

    await docCustomer.update(customer.toJson());
  }

  Future<void> deleteCustomer(Customers customer) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(customer.id)
        .delete();
  }
}
