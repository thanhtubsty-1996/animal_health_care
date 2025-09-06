import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/entities/pet.dart';
import 'package:animal_health_app/domain/repositories/pet_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetRepositoryImpl implements PetRepository {
  final FirebaseFirestore _firestore;

  PetRepositoryImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  Future<(Pet, Customer)> getPetById(String customerId, String petId) async {
    final petDoc = await _firestore.collection('pets').doc(petId).get();
    final customerDoc = await _firestore.collection('customers').doc(customerId).get();
    
    final pet = Pet.fromJson(petDoc.data()!);
    final customer = Customer.fromJson(customerDoc.data()!);
    
    return (pet, customer);
  }
}
