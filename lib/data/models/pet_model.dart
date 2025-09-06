
import 'package:animal_health_app/domain/entities/pet.dart';

class PetModel {
  final String id;
  final String name;
  final String species;
  final String breed;
  final DateTime birthDate;
  final double weight;

  PetModel({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.birthDate,
    required this.weight,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      birthDate: DateTime.parse(json['birthDate']),
      weight: (json['weight'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'breed': breed,
      'birthDate': birthDate.toIso8601String(),
      'weight': weight,
    };
  }

  // Chuyển đổi từ Data Model sang Domain Entity
  Pet toEntity() {
    return Pet(
      id: id,
      name: name,
      species: species,
      breed: breed,
      birthDate: birthDate,
      weight: weight,
      // Tính toán tuổi từ ngày sinh
      age: DateTime.now().difference(birthDate).inDays ~/ 365,
    );
  }
}
