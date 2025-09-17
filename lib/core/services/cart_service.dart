import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';

class CartService {
  static const String _cartKey = 'cart_items';
  static CartService? _instance;
  
  CartService._internal();
  
  static CartService get instance {
    _instance ??= CartService._internal();
    return _instance!;
  }

  Future<List<CartItemModel>> getCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);
      
      if (cartJson == null) return [];
      
      final List<dynamic> cartList = json.decode(cartJson);
      return cartList.map((item) => CartItemModel.fromJson(item)).toList();
    } catch (e) {
      print('Error getting cart items: $e');
      return [];
    }
  }

  Future<bool> addToCart(CartItemModel item) async {
    try {
      final cartItems = await getCartItems();
      
      final existingIndex = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
      
      if (existingIndex != -1) {
        cartItems[existingIndex] = cartItems[existingIndex].copyWith(
          quantity: cartItems[existingIndex].quantity + 1,
        );
      } else {
        cartItems.add(item.copyWith(quantity: 1));
      }
      
      return await _saveCartItems(cartItems);
    } catch (e) {
      print('Error adding to cart: $e');
      return false;
    }
  }

  Future<bool> updateQuantity(int itemId, int quantity) async {
    try {
      final cartItems = await getCartItems();
      final itemIndex = cartItems.indexWhere((item) => item.id == itemId);
      
      if (itemIndex != -1) {
        if (quantity <= 0) {
          cartItems.removeAt(itemIndex);
        } else {
          cartItems[itemIndex] = cartItems[itemIndex].copyWith(quantity: quantity);
        }
        return await _saveCartItems(cartItems);
      }
      return false;
    } catch (e) {
      print('Error updating quantity: $e');
      return false;
    }
  }

  Future<bool> removeFromCart(int itemId) async {
    try {
      final cartItems = await getCartItems();
      cartItems.removeWhere((item) => item.id == itemId);
      return await _saveCartItems(cartItems);
    } catch (e) {
      print('Error removing from cart: $e');
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_cartKey);
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }

  Future<int> getCartItemCount() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<int>(0, (sum, item) => sum + item.quantity);
    } catch (e) {
      print('Error getting cart count: $e');
      return 0;
    }
  }

  Future<double> getCartTotal() async {
    try {
      final cartItems = await getCartItems();
      return cartItems.fold<double>(0.0, (sum, item) => sum + (item.price * item.quantity));
    } catch (e) {
      print('Error getting cart total: $e');
      return 0.0;
    }
  }

  Future<bool> _saveCartItems(List<CartItemModel> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = json.encode(items.map((item) => item.toJson()).toList());
      return await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      print('Error saving cart items: $e');
      return false;
    }
  }
}
