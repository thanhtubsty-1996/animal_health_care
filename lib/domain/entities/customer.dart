
import 'package:equatable/equatable.dart';
import 'pet.dart'; // Import Pet entity

class Customer extends Equatable {
  final String id;
  final String name;
  final String contact; // Đổi từ phoneNumber
  final String email;
  final String address;
  final DateTime registrationDate; // Đổi từ createdAt
  final List<Pet> pets; // Chứa danh sách đối tượng Pet
  final int petCount;

  const Customer({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
    required this.address,
    required this.registrationDate,
    required this.pets,
    required this.petCount,
  });

  @override
  List<Object?> get props => [id, name, contact, email, address, registrationDate, pets, petCount];
}
