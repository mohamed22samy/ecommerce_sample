import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

class HomeState extends Equatable {
  final RequestStatus categoriesStatus;
  final List<CategoryEntity> categories;
  final RequestStatus productsStatus;
  final List<ProductEntity> products;
  final String errorMessage;

  const HomeState({
    this.categoriesStatus = RequestStatus.initial,
    this.categories = const [],
    this.productsStatus = RequestStatus.initial,
    this.products = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    RequestStatus? categoriesStatus,
    List<CategoryEntity>? categories,
    RequestStatus? productsStatus,
    List<ProductEntity>? products,
    String? errorMessage,
  }) {
    return HomeState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categories: categories ?? this.categories,
      productsStatus: productsStatus ?? this.productsStatus,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [categoriesStatus, categories, productsStatus, products, errorMessage];
}
