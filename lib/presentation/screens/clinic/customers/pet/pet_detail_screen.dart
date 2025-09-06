import 'package:animal_health_app/presentation/bloc/pet_detail/pet_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PetDetailScreen extends StatelessWidget {
  final String customerId;
  final String petId;

  const PetDetailScreen({
    super.key,
    required this.customerId,
    required this.petId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<PetDetailBloc, PetDetailState>(
        listener: (context, state) {
          if (state is PetDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PetDetailLoaded) {
            final pet = state.pet;
            final owner = state.owner;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  pinned: true,
                  leading: const BackButton(),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(pet.name, style: const TextStyle(shadows: [Shadow(blurRadius: 10.0)])),
                    background: Hero(
                      tag: 'pet-image-${pet.id}',
                      child: Image.network(
                        'https://picsum.photos/seed/${pet.id}/800/600',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMainInfoCard(theme, pet),
                        const SizedBox(height: 24),
                        _buildOwnerCard(context, theme, owner),
                        const SizedBox(height: 24),
                         _buildDetailsCard(theme, pet),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildMainInfoCard(ThemeData theme, dynamic pet) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('${pet.species} - ${pet.breed}', style: theme.textTheme.titleMedium?.copyWith(color: theme.textTheme.bodySmall?.color)),
            const SizedBox(height: 8),
            Chip(
              avatar: const Icon(Icons.cake_outlined, size: 18),
              label: Text('${pet.age} tuổi'),
              backgroundColor: theme.colorScheme.primaryContainer.withAlpha(128),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerCard(BuildContext context, ThemeData theme, dynamic owner) {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text('Chủ sở hữu', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
         const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person_outline)),
            title: Text(owner.name),
            subtitle: Text(owner.contact),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.go('/clinic/customers/${owner.id}'),
          ),
        ),
      ],
    );
  }

   Widget _buildDetailsCard(ThemeData theme, dynamic pet) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text('Thông tin chi tiết', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
         const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                  _buildInfoRow(theme, Icons.monitor_weight_outlined, 'Cân nặng', '${pet.weight} kg'),
                  const Divider(height: 20),
                  _buildInfoRow(theme, Icons.perm_identity_outlined, 'Mã định danh', pet.id, isMonospace: true),
              ],
            ),
          ),
        ),
      ],
    );
   }

   Widget _buildInfoRow(ThemeData theme, IconData icon, String label, String value, {bool isMonospace = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 16),
          Text('$label:', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value, 
              style: isMonospace 
                  ? theme.textTheme.bodyMedium?.copyWith(fontFamily: 'monospace') 
                  : theme.textTheme.bodyLarge,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
