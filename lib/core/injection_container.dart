import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com', 
        connectTimeout: const Duration(seconds: 5),
      ),
    ),
  );

}
