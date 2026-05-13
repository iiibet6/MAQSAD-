import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });
}

class CartService {
  static final ValueNotifier<List<CartItem>> cartItems = ValueNotifier([]);
  static String? currentRestaurantName;

  static void setRestaurant(String restaurantName) {
    if (currentRestaurantName != restaurantName) {
      currentRestaurantName = restaurantName;
      clearCart();
    }
  }

  static void addToCart(MenuItem item) {
    final items = [...cartItems.value];

    final existingIndex = items.indexWhere(
      (e) => e.item.name == item.name,
    );

    if (existingIndex != -1) {
      items[existingIndex].quantity++;
    } else {
      items.add(CartItem(item: item));
    }

    cartItems.value = items;
  }

  static void removeFromCart(MenuItem item) {
    final items = [...cartItems.value];

    items.removeWhere(
      (e) => e.item.name == item.name,
    );

    cartItems.value = items;
  }

  static double get totalPrice {
    double total = 0;

    for (final cartItem in cartItems.value) {
      total +=
          (double.tryParse(cartItem.item.price) ?? 0) *
          cartItem.quantity;
    }

    return total;
  }

  static void clearCart() {
    cartItems.value = [];
  }
}