import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:animal_health_app/domain/usecases/get_all_customers_usecase.dart';
import 'package:animal_health_app/domain/entities/customer.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  final GetAllCustomersUseCase getAllCustomersUseCase;

  CustomerListBloc({required this.getAllCustomersUseCase})
      : super(CustomerListInitial()) {
    on<LoadCustomerList>((event, emit) async {
      emit(CustomerListLoading());
      try {
        final customers = await getAllCustomersUseCase();
        emit(CustomerListLoaded(customers));
      } catch (e) {
        emit(CustomerListError('Không thể tải danh sách khách hàng: $e'));
      }
    });
  }
}
