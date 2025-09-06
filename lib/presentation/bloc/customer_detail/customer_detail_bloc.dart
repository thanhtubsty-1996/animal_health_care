
import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'customer_detail_event.dart';
part 'customer_detail_state.dart';

class CustomerDetailBloc extends Bloc<CustomerDetailEvent, CustomerDetailState> {
  final GetCustomerByIdUseCase getCustomerByIdUseCase;

  CustomerDetailBloc({required this.getCustomerByIdUseCase})
      : super(CustomerDetailInitial()) {
    on<LoadCustomerDetail>(_onLoadCustomerDetail);
  }

  Future<void> _onLoadCustomerDetail(
    LoadCustomerDetail event,
    Emitter<CustomerDetailState> emit,
  ) async {
    emit(CustomerDetailLoading());
    try {
      final customer = await getCustomerByIdUseCase(event.customerId);
      if (customer != null) {
        emit(CustomerDetailLoaded(customer));
      } else {
        emit(const CustomerDetailError('Không tìm thấy khách hàng'));
      }
    } catch (e) {
      emit(CustomerDetailError('Lỗi tải dữ liệu: ${e.toString()}'));
    }
  }
}
