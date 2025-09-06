import 'package:freezed_annotation/freezed_annotation.dart';
import 'pet.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String name,
    String? phoneNumber,
    String? email,
    String? address,
    required DateTime registrationDate,
    required List<Pet> pets,
    required int petCount,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}
