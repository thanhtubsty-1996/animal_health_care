import 'package:animal_health_app/domain/entities/customer.dart';
import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddEditCustomerScreen extends StatelessWidget {
  const AddEditCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm khách hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Tên khách hàng'),
                validator: (value) =>
                    value!.isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newCustomer = Customer(
                      id: const Uuid().v4(),
                      name: nameController.text,
                      phoneNumber: phoneController.text,
                      email: emailController.text,
                      address: addressController.text,
                      petCount: 0,
                      pets: const [],
                      registrationDate: DateTime.now(),
                    );
                    context
                        .read<CustomerListBloc>()
                        .add(AddCustomer(newCustomer));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
