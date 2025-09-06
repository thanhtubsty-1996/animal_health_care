import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Phòng khám'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context: context,
              theme: theme,
              icon: Icons.people_alt_outlined,
              title: 'Khách hàng',
              subtitle: 'Quản lý hồ sơ & lịch hẹn',
              onTap: () => context.go('/clinic'), // Sẽ cần cập nhật route này sau
            ),
            _buildFeatureCard(
              context: context,
              theme: theme,
              icon: Icons.pets_outlined,
              title: 'Danh bạ Thú cưng',
              subtitle: 'Tìm kiếm & tra cứu hồ sơ',
              onTap: () => context.go('/clinic/pets'),
            ),
            _buildFeatureCard(
              context: context,
              theme: theme,
              icon: Icons.calendar_today_outlined,
              title: 'Lịch hẹn',
              subtitle: 'Xem & sắp xếp lịch làm việc',
              onTap: () {},
            ),
             _buildFeatureCard(
              context: context,
              theme: theme,
              icon: Icons.inventory_2_outlined,
              title: 'Kho thuốc & Vật tư',
              subtitle: 'Quản lý tồn kho',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withAlpha(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}
