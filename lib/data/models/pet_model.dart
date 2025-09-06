
import 'package:animal_health_app/domain/entities/pet.dart';

class PetModel {
  final String id;
  final String name;
  final String species;
  final String breed;
  final DateTime birthDate;
  final double weight;
  final String ownerId; // Add ownerId

  PetModel({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.birthDate,
    required this.weight,
    required this.ownerId,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      birthDate: DateTime.parse(json['birthDate']),
      weight: (json['weight'] as num).toDouble(),
      ownerId: json['ownerId'],
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
      'ownerId': ownerId,
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
      age: DateTime.now().difference(birthDate).inDays ~/ 365,
    );
  }

  PetModel copyWith({
    String? id,
    String? name,
    String? species,
    String? breed,
    DateTime? birthDate,
    double? weight,
    String? ownerId,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      birthDate: birthDate ?? this.birthDate,
      weight: weight ?? this.weight,
      ownerId: ownerId ?? this.ownerId,
    );
  }
}
