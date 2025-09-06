
import 'package:animal_health_app/domain/entities/customer.dart';
import 'pet_model.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phoneNumber; // Giữ nguyên cho API
  final String email;
  final String address;
  final DateTime createdAt; // Giữ nguyên cho API
  final List<PetModel> pets; // Danh sách PetModel

  CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.createdAt,
    required this.pets,
  });

  // Chuyển đổi từ JSON
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    var petList = json['pets'] as List;
    List<PetModel> pets = petList.map((i) => PetModel.fromJson(i)).toList();
    
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address'],
      createdAt: DateTime.parse(json['createdAt']),
      pets: pets,
    );
  }

  // Chuyển đổi sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'pets': pets.map((p) => p.toJson()).toList(),
    };
  }

  // Chuyển đổi từ Model sang Entity (Ánh xạ các trường)
  Customer toEntity() {
    return Customer(
      id: id,
      name: name,
      contact: phoneNumber, // Ánh xạ phoneNumber -> contact
      email: email,
      address: address,
      registrationDate: createdAt, // Ánh xạ createdAt -> registrationDate
      pets: pets.map((p) => p.toEntity()).toList(),
      petCount: pets.length,
    );
  }

  // Chuyển đổi từ Entity sang Model
  factory CustomerModel.fromEntity(Customer entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.contact, // Ánh xạ contact -> phoneNumber
      email: entity.email,
      address: entity.address,
      createdAt: entity.registrationDate, // Ánh xạ registrationDate -> createdAt
      // Chuyển đổi ngược lại không cần thiết cho PetModel trong ngữ cảnh này
      // vì chúng ta không tạo PetModel từ Pet entity.
      pets: [], // Giả định không cần chuyển đổi ngược danh sách thú cưng
    );
  }
}
