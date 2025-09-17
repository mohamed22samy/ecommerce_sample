import 'package:flutter/material.dart';

class CartItemModel {
  final int id;
  final String name;
  final String collection;
  final double price;
  final int quantity;
  final bool isFavorite;
  final String imageUrl;
  final Color? imageColor;

  CartItemModel({
    required this.id,
    required this.name,
    required this.collection,
    required this.price,
    required this.quantity,
    this.isFavorite = false,
    required this.imageUrl,
    this.imageColor,
  });

  CartItemModel copyWith({
    int? id,
    String? name,
    String? collection,
    double? price,
    int? quantity,
    bool? isFavorite,
    String? imageUrl,
    Color? imageColor,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      collection: collection ?? this.collection,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
      imageColor: imageColor ?? this.imageColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'collection': collection,
      'price': price,
      'quantity': quantity,
      'isFavorite': isFavorite,
      'imageUrl': imageUrl,
      'imageColorValue': imageColor?.value,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      collection: json['collection'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      isFavorite: json['isFavorite'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String,
      imageColor: json['imageColorValue'] != null 
          ? Color(json['imageColorValue'] as int)
          : null,
    );
  }

  factory CartItemModel.fromProduct({
    required int id,
    required String title,
    required double price,
    required String imageUrl,
    String collection = "Product Collection",
    Color? imageColor,
  }) {
    return CartItemModel(
      id: id,
      name: title,
      collection: collection,
      price: price,
      quantity: 1,
      isFavorite: false,
      imageUrl: imageUrl,
      imageColor: imageColor,
    );
  }

  @override
  String toString() {
    return 'CartItemModel(id: $id, name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItemModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
