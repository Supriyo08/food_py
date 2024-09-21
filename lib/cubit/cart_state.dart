import 'package:campus_haat/models/product_model.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartState {
  final List<CartItem> cartItems;
  final double totalAmount;

  CartState({
    this.cartItems = const [],
    this.totalAmount = 0.0,
  });

  CartState copyWith({
    List<CartItem>? cartItems,
    double? totalAmount,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
