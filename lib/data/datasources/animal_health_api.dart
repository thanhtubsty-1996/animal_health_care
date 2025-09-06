import 'package:faker/faker.dart';
import 'package:animal_health_app/data/models/customer_model.dart';
import 'package:animal_health_app/data/models/pet_model.dart';

// Lớp này mô phỏng việc gọi API để lấy dữ liệu
class AnimalHealthApi {
  final Faker _faker = Faker();

  // Tạo một danh sách khách hàng giả
  List<CustomerModel> _generateFakeCustomers(int count) {
    return List.generate(count, (index) {
      final customerId = _faker.guid.guid();
      return CustomerModel(
        id: customerId,
        name: _faker.person.name(),
        contact: _faker.phoneNumber.us(),
        // Thêm các trường bị thiếu
        email: _faker.internet.email(),
        address: _faker.address.streetAddress(),
        registrationDate: _faker.date.past(years: 5),
        pets: _generateFakePets(customerId, _faker.randomGenerator.integer(3, min: 0)), 
        petCount: 0, // Sẽ được cập nhật sau
      );
    });
  }

  // Tạo một danh sách thú cưng giả cho một khách hàng
  List<PetModel> _generateFakePets(String ownerId, int count) {
    return List.generate(count, (index) {
      return PetModel(
        id: _faker.guid.guid(),
        name: _faker.animal.name(), // Giữ tên có ý nghĩa
        species: _faker.animal.name(), // Sử dụng tên động vật cho loài
        breed: 'Breed', // Giả giống loài
        birthDate: _faker.date.past(years: 10),
        ownerId: ownerId,
        weight: _faker.randomGenerator.decimal(scale: 10, min: 1),
      );
    });
  }

  // API giả: Lấy tất cả khách hàng
  Future<List<CustomerModel>> getAllCustomers() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Giả lập độ trễ mạng
    final customers = _generateFakeCustomers(15);
    // Cập nhật số lượng thú cưng
    final updatedCustomers = customers.map((c) => c.copyWith(petCount: c.pets.length)).toList();
    return updatedCustomers;
  }

  // API giả: Lấy khách hàng theo ID
  Future<CustomerModel> getCustomerById(String customerId) async {
     await Future.delayed(const Duration(milliseconds: 300));
     final customer = _generateFakeCustomers(1).first;
     return customer.copyWith(id: customerId, pets: _generateFakePets(customerId, 3));
  }

  Future<PetModel> getPetById(String customerId, String petId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final pet = _generateFakePets(customerId, 1).first;
    return pet.copyWith(id: petId, ownerId: customerId);
  }
}
