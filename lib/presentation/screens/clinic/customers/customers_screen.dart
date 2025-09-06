import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_bloc.dart';
import 'package:animal_health_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Khách hàng'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Logic to open drawer will be added in MainLayout
          },
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: BlocBuilder<CustomerListBloc, CustomerListState>(
        builder: (context, state) {
          if (state is CustomerListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerListLoaded) {
            if (state.customers.isEmpty) {
              return const Center(
                child: Text(
                  'Chưa có khách hàng nào.\nNhấn "+" để thêm mới.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.customers.length,
              itemBuilder: (context, index) {
                final customer = state.customers[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () => context.go('/clinic/customers/${customer.id}'),
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          _buildInfoRow(
                            context,
                            icon: Icons.phone,
                            text: customer.phoneNumber ?? 'Chưa có số điện thoại',
                          ),
                          const SizedBox(height: 8.0),
                          _buildInfoRow(
                            context,
                            icon: Icons.email,
                            text: customer.email ?? 'Chưa có email',
                          ),
                           const SizedBox(height: 8.0),
                          _buildInfoRow(
                            context,
                            icon: Icons.location_on,
                            text: customer.address ?? 'Chưa có địa chỉ',
                          ),
                        ],
                      ),
                    ),
                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/clinic/customers/add');
        },
        tooltip: 'Thêm khách hàng',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String text}) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18.0, color: theme.colorScheme.primary),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
