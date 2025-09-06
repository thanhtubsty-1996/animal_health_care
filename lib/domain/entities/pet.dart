
import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String id;
  final String name;
  final String species; 
  final String breed;
  final int age; 
  final double weight; 
  final DateTime birthDate;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.weight,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [id, name, species, breed, age, weight, birthDate];
}
