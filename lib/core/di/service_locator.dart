import 'package:get_it/get_it.dart';
import '../../features/product/data/datasources/product_remote_data_source.dart';
import '../../features/product/domain/usecases/get_all_products_usecase.dart';
import '../../features/product/presentation/blocs/product_bloc.dart';
import '../../features/product/presentation/blocs/crud/product_crud_bloc.dart';

final sl = GetIt.instance;

void initDependencies() {
  // ✅ Remote Data Source
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSource());

  // ✅ UseCase
  sl.registerLazySingleton<GetAllProductsUseCase>(
        () => GetAllProductsUseCase(sl()),
  );

  // ✅ ProductBloc
  sl.registerFactory<ProductBloc>(() => ProductBloc(
    getAllProductsUseCase: sl(),
    dataSource: sl(),
  ));

  // ✅ CRUD BLoC
  sl.registerFactory<ProductCrudBloc>(() => ProductCrudBloc(remoteDataSource: sl()));
}
