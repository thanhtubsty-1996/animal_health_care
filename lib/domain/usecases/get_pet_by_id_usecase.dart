import 'package:animal_health_app/domain/entities/pet.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';

class GetPetByIdUseCase {
  final CustomerRepository repository;

  GetPetByIdUseCase(this.repository);

  Future<Pet> call(String customerId, String petId) {
    return repository.getPetById(customerId, petId);
  }
}
