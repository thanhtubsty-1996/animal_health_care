import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';

class GetAllCustomersUseCase {
  final CustomerRepository repository;

  GetAllCustomersUseCase({required this.repository});

  Future<List<Customer>> call() async {
    return await repository.getCustomers();
  }
}
