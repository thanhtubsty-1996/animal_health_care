
part of 'customer_detail_bloc.dart';

@immutable
abstract class CustomerDetailState extends Equatable {
  const CustomerDetailState();

  @override
  List<Object> get props => [];
}

class CustomerDetailInitial extends CustomerDetailState {}

class CustomerDetailLoading extends CustomerDetailState {}

class CustomerDetailLoaded extends CustomerDetailState {
  final Customer customer;

  const CustomerDetailLoaded(this.customer);

  @override
  List<Object> get props => [customer];
}

class CustomerDetailError extends CustomerDetailState {
  final String message;

  const CustomerDetailError(this.message);

  @override
  List<Object> get props => [message];
}
