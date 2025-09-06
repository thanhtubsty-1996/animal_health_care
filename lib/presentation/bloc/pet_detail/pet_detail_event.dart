
part of 'pet_detail_bloc.dart';

@immutable
abstract class PetDetailEvent extends Equatable {
  const PetDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadPetDetail extends PetDetailEvent {
  final String customerId;
  final String petId;

  const LoadPetDetail({required this.customerId, required this.petId});

  @override
  List<Object> get props => [customerId, petId];
}
