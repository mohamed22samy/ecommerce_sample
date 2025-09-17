import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/usecases/categories_use_case.dart';
import '../../domain/usecases/products_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeBloc({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(const HomeState()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<GetProductsEvent>(_onGetProducts);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoriesStatus: RequestStatus.loading));

    final result = await getCategoriesUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        categoriesStatus: RequestStatus.error,
        errorMessage: failure.error.toString(),
      )),
      (categories) => emit(state.copyWith(
        categoriesStatus: RequestStatus.loaded,
        categories: categories,
        errorMessage: '',
      )),
    );
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(productsStatus: RequestStatus.loading));

    final result = await getProductsUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        productsStatus: RequestStatus.error,
        errorMessage: failure.error.toString(),
      )),
      (products) => emit(state.copyWith(
        productsStatus: RequestStatus.loaded,
        products: products,
        errorMessage: '',
      )),
    );
  }
}
