
part of 'pet_detail_bloc.dart';

@immutable
abstract class PetDetailState extends Equatable {
  const PetDetailState();

  @override
  List<Object> get props => [];
}

class PetDetailInitial extends PetDetailState {}

class PetDetailLoading extends PetDetailState {}

class PetDetailLoaded extends PetDetailState {
  final Pet pet;
  final Customer owner; // Cũng cần thông tin của chủ

  const PetDetailLoaded({required this.pet, required this.owner});

  @override
  List<Object> get props => [pet, owner];
}

class PetDetailError extends PetDetailState {
  final String message;

  const PetDetailError(this.message);

  @override
  List<Object> get props => [message];
}
