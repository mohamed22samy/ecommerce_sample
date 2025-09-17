
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent();
}

class GetProductsEvent extends HomeEvent {
  const GetProductsEvent();
}

