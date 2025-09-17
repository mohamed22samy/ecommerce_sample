import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.name,
  });

  factory CategoryModel.fromJson(String json) {
    return CategoryModel(
      name: json,
    );
  }

  String toJson() {
    return name;
  }

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      name: entity.name,
    );
  }

  @override
  List<Object?> get props => [name];
}
