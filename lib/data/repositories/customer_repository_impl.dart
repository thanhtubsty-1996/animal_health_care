
import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final FirebaseFirestore _firestore;

  CustomerRepositoryImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  Future<List<Customer>> getCustomers() async {
    final snapshot = await _firestore.collection('customers').get();
    return snapshot.docs
        .map((doc) => Customer.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<Customer> getCustomerById(String customerId) async {
    final doc = await _firestore.collection('customers').doc(customerId).get();
    return Customer.fromJson(doc.data()!);
  }

  @override
  Future<void> addCustomer(Customer customer) {
    return _firestore
        .collection('customers')
        .doc(customer.id)
        .set(customer.toJson());
  }

  @override
  Future<void> updateCustomer(Customer customer) {
    return _firestore
        .collection('customers')
        .doc(customer.id)
        .update(customer.toJson());
  }

  @override
  Future<void> deleteCustomer(String id) {
    return _firestore.collection('customers').doc(id).delete();
  }
}
