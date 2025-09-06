import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/entities/pet.dart';

abstract class PetRepository {
  Future<(Pet, Customer)> getPetById(String customerId, String petId);
}
