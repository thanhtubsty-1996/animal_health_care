import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/dependency_injection.dart' as di;
import 'core/router/app_router.dart';
import 'presentation/bloc/customer_list/customer_list_bloc.dart';
import 'presentation/bloc/customer_detail/customer_detail_bloc.dart';
import 'presentation/bloc/pet_detail/pet_detail_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerListBloc>(
          create: (_) => di.sl<CustomerListBloc>()..add(LoadCustomerList()),
        ),
        BlocProvider<CustomerDetailBloc>(
          create: (_) => di.sl<CustomerDetailBloc>(),
        ),
         BlocProvider<PetDetailBloc>(
          create: (_) => di.sl<PetDetailBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Animal Health App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter().router,
      ),
    );
  }
}
