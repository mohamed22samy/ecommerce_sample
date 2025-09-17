import 'package:dio/dio.dart';
import 'package:ecommerce_sample/features/home/data/datasource/remote_datasourc.dart';
import 'package:ecommerce_sample/features/home/data/repository/home_repository_impl.dart';
import 'package:ecommerce_sample/features/home/domain/repository/home_repository.dart';
import 'package:ecommerce_sample/features/home/domain/usecases/categories_use_case.dart';
import 'package:ecommerce_sample/features/home/domain/usecases/products_use_case.dart';
import 'package:ecommerce_sample/features/home/presentation/controller/home_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_sample/core/services/storage_service/storage_operations.dart';
import 'package:ecommerce_sample/core/blocs/theme_bloc.dart';
import '../network/api_constant.dart';
import '../utils/app_string.dart';
import '../utils/lang/app_string_ar.dart';
import 'storage_service/storage_impl.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    /// Bloc
    sl.registerLazySingleton(() => ThemeBloc());

    sl.registerLazySingleton(() => HomeBloc(
          getCategoriesUseCase: sl(),
          getProductsUseCase: sl(),
        ));
   
    // Use Cases
    sl.registerLazySingleton<GetCategoriesUseCase>(
        () => GetCategoriesUseCase(sl()));
    sl.registerLazySingleton<GetProductsUseCase>(
        () => GetProductsUseCase(sl()));
   

    // Repository
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: sl()));
   

    // DATA SOURCE
    sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(dio: sl()));
   

    // Storage Service
    sl.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage());
    sl.registerLazySingleton<StorageOperations>(() => StorageServiceImpl(sl()));

    // LANG
    sl.registerLazySingleton<AppString>(() => AppStringAR());

    // Dio

    sl.registerSingletonAsync<Dio>(() async {
      final langCode = await sl<StorageOperations>().read("lang_code") ?? "ar";

      return Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 3000),
        receiveTimeout: const Duration(seconds: 3000),
        sendTimeout: const Duration(seconds: 3000),
        validateStatus: (status) {
          return status! < 501;
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '',
          'lang': langCode,
        },
      ));
    });
  }
}
