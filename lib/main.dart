import 'package:animal_health_app/firebase_options.dart';
import 'package:animal_health_app/presentation/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/dependency_injection.dart' as di;
import 'core/router/app_router.dart';
import 'presentation/bloc/customer_list/customer_list_bloc.dart';
import 'presentation/bloc/customer_detail/customer_detail_bloc.dart';
import 'presentation/bloc/pet_detail/pet_detail_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MultiBlocProvider(
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
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              title: 'Animal Health App',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
