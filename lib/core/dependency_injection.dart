import 'package:animal_health_app/data/datasources/animal_health_api.dart';
import 'package:animal_health_app/data/repositories/customer_repository_impl.dart';
import 'package:animal_health_app/domain/repositories/customer_repository.dart';
import 'package:animal_health_app/domain/usecases/get_all_customers_usecase.dart';
import 'package:animal_health_app/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:animal_health_app/domain/usecases/get_pet_by_id_usecase.dart';
import 'package:animal_health_app/presentation/bloc/customer_list/customer_list_bloc.dart';
import 'package:animal_health_app/presentation/bloc/customer_detail/customer_detail_bloc.dart';
import 'package:animal_health_app/presentation/bloc/pet_detail/pet_detail_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Blocs
  sl.registerFactory(
    () => CustomerListBloc(getAllCustomersUseCase: sl()),
  );
  sl.registerFactory(
    () => CustomerDetailBloc(getCustomerByIdUseCase: sl()),
  );
  sl.registerFactory(
    () => PetDetailBloc(getPetByIdUseCase: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAllCustomersUseCase(sl()));
  sl.registerLazySingleton(() => GetCustomerByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetPetByIdUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(api: sl()),
  );

  // Data Sources
  sl.registerLazySingleton(() => AnimalHealthApi());
}
