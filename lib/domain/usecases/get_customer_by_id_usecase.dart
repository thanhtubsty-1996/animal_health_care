
import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';

class GetCustomerByIdUseCase {
  final CustomerRepository repository;

  GetCustomerByIdUseCase(this.repository);

  Future<Customer?> call(String customerId) {
    return repository.getCustomerById(customerId);
  }
}
