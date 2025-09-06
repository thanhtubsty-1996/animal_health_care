import 'package:animal_health_app/domain/entities/pet.dart';
import 'package:flutter/material.dart';

/// Widget hiển thị danh sách thú cưng thuộc về một khách hàng.
class PetListScreen extends StatelessWidget {
  final List<Pet> pets;

  const PetListScreen({super.key, required this.pets});

  // Hàm tính tuổi từ ngày sinh
  String _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    if (months < 0 || (months == 0 && now.day < birthDate.day)) {
      years--;
      months += 12;
    }
    if (years > 0) {
      return '$years tuổi, $months tháng';
    } else {
      return '$months tháng';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (pets.isEmpty) {
      return const Center(
        child: Text('Khách hàng này chưa có thú cưng nào.'),
      );
    }

    return ListView.builder(
      shrinkWrap: true, // Quan trọng khi lồng trong một ScrollView khác
      physics: const NeverScrollableScrollPhysics(), // Để ScrollView cha xử lý
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.secondary.withAlpha(25),
              foregroundColor: theme.colorScheme.secondary,
              child: const Icon(Icons.pets_outlined),
            ),
            title: Text(pet.name, style: theme.textTheme.titleMedium),
            subtitle: Text(
              '${pet.species} - ${_calculateAge(pet.birthDate)}',
              style: theme.textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Điều hướng đến màn hình chi tiết thú cưng
              // context.go('/clinic/customers/${pet.ownerId}/pets/${pet.id}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Xem chi tiết cho ${pet.name}')),
              );
            },
          ),
        );
      },
    );
  }
}
