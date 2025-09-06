import 'package:animal_health_app/data/repositories/customer_repository_impl.dart';
import 'package:animal_health_app/data/repositories/pet_repository_impl.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';
import 'package:animal_health_app/domain/repositories/pet_repository.dart';
import 'package:animal_health_app/domain/usecases/add_customer_usecase.dart';
import 'package:animal_health_app/domain/usecases/get_all_customers_usecase.dart';
import 'package:animal_health_app/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:animal_health_app/domain/usecases/get_pet_by_id_usecase.dart';
import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_bloc.dart';
import 'package:animal_health_app/presentation/bloc/customer_detail/customer_detail_bloc.dart';
import 'package:animal_health_app/presentation/bloc/pet_detail/pet_detail_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final sl = GetIt.instance;

void init() {
  // Blocs
  sl.registerFactory(
    () => CustomerListBloc(
      getAllCustomersUseCase: sl(),
      addCustomerUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => CustomerDetailBloc(getCustomerByIdUseCase: sl()),
  );
  sl.registerFactory(
    () => PetDetailBloc(getPetByIdUseCase: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAllCustomersUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCustomerByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetPetByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddCustomerUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(firestore: sl()),
  );
  sl.registerLazySingleton<PetRepository>(
    () => PetRepositoryImpl(firestore: sl()),
  );

  // Data Sources
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
