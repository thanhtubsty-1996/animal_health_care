
import 'package:animal_health_app/domain/entities/customer.dart';
import 'pet_model.dart';

class CustomerModel {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final DateTime createdAt;
  final List<PetModel> pets;

  CustomerModel({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    this.address,
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
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      registrationDate: createdAt,
      pets: pets.map((p) => p.toEntity()).toList(),
      petCount: pets.length,
    );
  }

  // Chuyển đổi từ Entity sang Model
  factory CustomerModel.fromEntity(Customer entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      address: entity.address,
      createdAt: entity.registrationDate,
      pets: [], 
    );
  }

  CustomerModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? address,
    DateTime? createdAt,
    List<PetModel>? pets,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      pets: pets ?? this.pets,
    );
  }
}
