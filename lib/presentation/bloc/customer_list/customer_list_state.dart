part of 'customer_list_bloc.dart';

abstract class CustomerListState extends Equatable {
  const CustomerListState();

  @override
  List<Object> get props => [];
}

class CustomerListInitial extends CustomerListState {}

class CustomerListLoading extends CustomerListState {}

class CustomerListLoaded extends CustomerListState {
  final List<Customer> customers;

  const CustomerListLoaded(this.customers);

  @override
  List<Object> get props => [customers];
}

class CustomerListError extends CustomerListState {
  final String message;

  const CustomerListError(this.message);

  @override
  List<Object> get props => [message];
}
