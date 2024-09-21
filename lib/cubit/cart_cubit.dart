import 'package:campus_haat/cubit/cart_state.dart';
import 'package:campus_haat/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  // for adding items or increasing item's quantity
  void addItem(Product product) {
    final existingItem = state.cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    final updatedItem = CartItem(
      product: product,
      quantity: existingItem.quantity + 1,
    );

    final updatedCart =
        state.cartItems.where((item) => item.product.id != product.id).toList();
    updatedCart.add(updatedItem);

    final updatedTotalAmount = updatedCart.fold(0.0, (total, item) {
      return total + (item.product.price * item.quantity);
    });

    emit(state.copyWith(
        cartItems: updatedCart, totalAmount: updatedTotalAmount));
  }

  // for removing items or decreasing items's quantity
  void removeItem(Product product) {
    final existingItem = state.cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 1) {
      // Decrease the quantity if it's more than 1
      final updatedItem = CartItem(
        product: product,
        quantity: existingItem.quantity - 1,
      );

      final updatedCart = state.cartItems
          .where((item) => item.product.id != product.id)
          .toList();
      updatedCart.add(updatedItem);

      final updatedTotalAmount = updatedCart.fold(0.0, (total, item) {
        return total + (item.product.price * item.quantity);
      });

      emit(state.copyWith(
          cartItems: updatedCart, totalAmount: updatedTotalAmount));
    } else {
      // If quantity is 1, remove the item completely from the cart
      final updatedCart = state.cartItems
          .where((item) => item.product.id != product.id)
          .toList();

      final updatedTotalAmount = updatedCart.fold(0.0, (total, item) {
        return total + (item.product.price * item.quantity);
      });

      emit(state.copyWith(
          cartItems: updatedCart, totalAmount: updatedTotalAmount));
    }
  }

  // to empty the cart
  void clearCart() {
    emit(CartState());
  }
}
