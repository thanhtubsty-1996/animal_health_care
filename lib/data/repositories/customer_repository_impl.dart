import 'package:animal_health_app/data/datasources/animal_health_api.dart';
import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/entities/pet.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final AnimalHealthApi api;

  CustomerRepositoryImpl({required this.api});

  @override
  Future<List<Customer>> getCustomers() async {
    final customerModels = await api.getAllCustomers();
    // Chuyển đổi từ Model sang Entity
    return customerModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Customer> getCustomerById(String customerId) async {
    final customerModel = await api.getCustomerById(customerId);
    return customerModel.toEntity();
  }

  @override
  Future<Pet> getPetById(String customerId, String petId) async {
    final petModel = await api.getPetById(customerId, petId);
    return petModel.toEntity();
  }

}
