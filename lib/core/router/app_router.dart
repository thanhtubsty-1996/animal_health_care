import 'package:animal_health_app/core/dependency_injection.dart';
import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_bloc.dart';
import 'package:animal_health_app/presentation/bloc/customer_detail/customer_detail_bloc.dart';
import 'package:animal_health_app/presentation/bloc/pet_detail/pet_detail_bloc.dart';
import 'package:animal_health_app/presentation/screens/clinic/customers/customer_detail_screen.dart';
import 'package:animal_health_app/presentation/screens/clinic/customers/customers_screen.dart';
import 'package:animal_health_app/presentation/screens/clinic/customers/pet/pet_detail_screen.dart';
import 'package:animal_health_app/presentation/screens/dashboard_screen.dart';
import 'package:animal_health_app/presentation/screens/main_layout.dart';
import 'package:animal_health_app/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/clinic',
            builder: (context, state) => BlocProvider(
              create: (context) => sl<CustomerListBloc>()..add(LoadCustomerList()),
              child: const CustomersScreen(),
            ),
            routes: [
              GoRoute(
                  path: 'customers/:customerId',
                  builder: (context, state) {
                    final customerId = state.pathParameters['customerId']!;
                    return BlocProvider(
                      create: (context) => sl<CustomerDetailBloc>()..add(LoadCustomerDetail(customerId)),
                      child: CustomerDetailScreen(customerId: customerId),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'pets/:petId',
                      builder: (context, state) {
                        final customerId = state.pathParameters['customerId']!;
                        final petId = state.pathParameters['petId']!;
                        return BlocProvider(
                          create: (context) => sl<PetDetailBloc>()..add(LoadPetDetail(customerId: customerId, petId: petId)),
                          child: PetDetailScreen(customerId: customerId, petId: petId),
                        );
                      },
                    ),
                  ]),
            ],
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Lỗi')),
      body: Center(
        child: Text('Không tìm thấy trang: ${state.error?.message}'),
      ),
    ),
  );
}
