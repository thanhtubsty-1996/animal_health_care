import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/entities/pet.dart';
import 'package:animal_health_app/domain/repositories/pet_repository.dart';

class GetPetByIdUseCase {
  final PetRepository repository;

  GetPetByIdUseCase({required this.repository});

  Future<(Pet, Customer)> call(String customerId, String petId) {
    return repository.getPetById(customerId, petId);
  }
}
