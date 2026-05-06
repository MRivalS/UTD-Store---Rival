import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'network/dio_client.dart';
import '../features/store/data/data_sources/product_remote_data_source.dart';
import '../features/store/data/repositories/product_repository_impl.dart';
import '../features/store/domain/repositories/product_repository.dart';
import '../features/store/presentation/cubit/product_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<DioClient>(() => DioClient(locator<Dio>()));

// DATA SOURCE
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: locator<Dio>()),
  );

  // REPOSITORY
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator<ProductRemoteDataSource>(),
    ),
  );

  locator.registerFactory(
    () => ProductCubit(repository: locator<ProductRepository>()),
  );

}
