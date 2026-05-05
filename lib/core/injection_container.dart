import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'network/dio_client.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<DioClient>(() => DioClient(locator<Dio>()));
}
