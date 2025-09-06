
part of 'customer_detail_bloc.dart';

@immutable
abstract class CustomerDetailEvent extends Equatable {
  const CustomerDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomerDetail extends CustomerDetailEvent {
  final String customerId;

  const LoadCustomerDetail(this.customerId);

  @override
  List<Object> get props => [customerId];
}
