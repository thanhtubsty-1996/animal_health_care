import 'package:equatable/equatable.dart';

abstract class CustomerListEvent extends Equatable {
  const CustomerListEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomers extends CustomerListEvent {}
