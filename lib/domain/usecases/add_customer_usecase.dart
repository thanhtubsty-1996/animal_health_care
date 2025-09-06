import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';

class AddCustomerUseCase {
  final CustomerRepository repository;

  AddCustomerUseCase(this.repository);

  Future<void> call(Customer customer) {
    return repository.addCustomer(customer);
  }
}
