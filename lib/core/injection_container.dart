import 'package:get_it/get_it.dart';
import 'network/dio_client.dart';
import '../features/store/data/data_sources/product_remote_data_source.dart';
import '../features/store/data/repositories/product_repository_impl.dart';
import '../features/store/domain/repositories/product_repository.dart';
import '../features/store/domain/splash_service.dart';
import '../features/store/presentation/cubit/product_cubit.dart';
import '../features/store/presentation/cubit_cart/cart_cubit.dart';
import '../features/store/presentation/cubit/bookmark_cubit.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<DioClient>(() => DioClient());

  locator.registerLazySingleton(() => SplashService());

  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: locator<DioClient>().dio),
  );

  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator<ProductRemoteDataSource>(),
    ),
  );

  locator.registerFactory(
    () => ProductCubit(repository: locator<ProductRepository>()),
  );

  locator.registerLazySingleton(() => CartCubit());

  locator.registerLazySingleton(() => BookmarkCubit());
}
