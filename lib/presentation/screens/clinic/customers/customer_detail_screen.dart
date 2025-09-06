import 'package:animal_health_app/presentation/bloc/customer_detail/customer_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomerDetailScreen extends StatelessWidget {
  final String customerId;

  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<CustomerDetailBloc, CustomerDetailState>(
        listener: (context, state) {
          if (state is CustomerDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is CustomerDetailLoading || state is CustomerDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CustomerDetailLoaded) {
            final customer = state.customer;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  leading: const BackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(customer.name, style: const TextStyle(shadows: [Shadow(blurRadius: 10.0)])),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://picsum.photos/seed/${customer.id}/800/400', 
                          fit: BoxFit.cover,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(theme, customer),
                        const SizedBox(height: 24),
                        Text('Danh sách thú cưng', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                if (customer.pets.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Khách hàng này chưa có thú cưng nào.', style: theme.textTheme.bodyMedium),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final pet = customer.pets[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.secondary.withAlpha(25),
                              foregroundColor: theme.colorScheme.secondary,
                              child: const Icon(Icons.pets),
                            ),
                            title: Text(pet.name, style: theme.textTheme.titleMedium),
                            subtitle: Text('${pet.species} - ${pet.breed}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              context.go('/clinic/customers/${customer.id}/pets/${pet.id}');
                            },
                          ),
                        );
                      },
                      childCount: customer.pets.length,
                    ),
                  ),
              ],
            );
          }
          // Trường hợp lỗi đã được xử lý bởi listener, 
          // nhưng chúng ta vẫn cần trả về một widget ở đây.
          // Có thể là một màn hình lỗi hoặc trống.
          return const Center(
            child: Text('Đang tải hoặc đã có lỗi xảy ra.'),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, dynamic customer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thông tin liên hệ', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 20),
            _buildInfoRow(theme, Icons.phone_outlined, customer.contact),
            _buildInfoRow(theme, Icons.email_outlined, customer.email),
            _buildInfoRow(theme, Icons.location_on_outlined, customer.address),
            _buildInfoRow(theme, Icons.calendar_today_outlined, 'Thành viên từ: ${customer.registrationDate.toLocal().toString().split(' ')[0]}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
