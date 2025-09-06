
import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/entities/pet.dart';
import 'package:animal_health_app/domain/usecases/get_pet_by_id_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pet_detail_event.dart';
part 'pet_detail_state.dart';

class PetDetailBloc extends Bloc<PetDetailEvent, PetDetailState> {
  final GetPetByIdUseCase getPetByIdUseCase;

  PetDetailBloc({required this.getPetByIdUseCase}) : super(PetDetailInitial()) {
    on<LoadPetDetail>(_onLoadPetDetail);
  }

  Future<void> _onLoadPetDetail(
    LoadPetDetail event,
    Emitter<PetDetailState> emit,
  ) async {
    emit(PetDetailLoading());
    try {
      final (pet, owner) = await getPetByIdUseCase(event.customerId, event.petId);
      emit(PetDetailLoaded(pet: pet, owner: owner));
    } catch (e) {
      emit(PetDetailError('Lỗi tải dữ liệu: ${e.toString()}'));
    }
  }
}
