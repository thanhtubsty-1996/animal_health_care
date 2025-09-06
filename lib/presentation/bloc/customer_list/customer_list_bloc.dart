import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/domain/usecases/add_customer_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:animal_health_app/domain/usecases/get_all_customers_usecase.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  final GetAllCustomersUseCase getAllCustomersUseCase;
  final AddCustomerUseCase addCustomerUseCase;

  CustomerListBloc({
    required this.getAllCustomersUseCase,
    required this.addCustomerUseCase,
  }) : super(CustomerListInitial()) {
    on<LoadCustomerList>((event, emit) async {
      emit(CustomerListLoading());
      try {
        final customers = await getAllCustomersUseCase();
        emit(CustomerListLoaded(customers));
      } catch (e) {
        emit(CustomerListError('Không thể tải danh sách khách hàng: $e'));
      }
    });

    on<AddCustomer>((event, emit) async {
      try {
        await addCustomerUseCase(event.customer);
        add(LoadCustomerList());
      } catch (e) {
        emit(CustomerListError('Không thể thêm khách hàng: $e'));
      }
    });
  }
}
