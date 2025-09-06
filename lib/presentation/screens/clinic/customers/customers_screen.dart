import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_bloc.dart';
import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khách hàng'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Mở drawer
          },
        ),
      ),
      body: BlocBuilder<CustomerListBloc, CustomerListState>(
        builder: (context, state) {
          if (state is CustomerListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerListLoaded) {
            return ListView.builder(
              itemCount: state.customers.length,
              itemBuilder: (context, index) {
                final customer = state.customers[index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.address),
                  onTap: () => context.go('/clinic/customers/${customer.id}'),
                );
              },
            );
          } else if (state is CustomerListError) {
            return Center(child: Text('Lỗi: ${state.message}'));
          } else {
            return const Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}
