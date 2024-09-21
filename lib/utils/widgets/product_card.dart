import 'package:campus_haat/cubit/cart_cubit.dart';
import 'package:campus_haat/cubit/cart_state.dart';
import 'package:campus_haat/models/product_model.dart';
import 'package:campus_haat/utils/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.discountPercentage,
    required this.price,
  });

  final Product product;
  final int discountPercentage;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Row(
        children: [
          const SizedBox(width: 5),
          // image of product
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.network(
              product.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  height: 100,
                  width: 100,
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title and discount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (discountPercentage > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$discountPercentage% off',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // info
                  Text(
                    product.info,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),

                  // time and category
                  const Row(
                    children: [
                      Icon(Icons.timer, size: 16),
                      SizedBox(width: 5),
                      Text("15 mins"), // used dummy data
                      SizedBox(width: 10),
                      Icon(Icons.restaurant_menu, size: 16),
                      SizedBox(width: 5),
                      Text("Lunch & Dinner"), // used dummy data
                    ],
                  ),
                  const SizedBox(height: 5),

                  // price and add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹$price',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          final cartItem = state.cartItems.firstWhere(
                            (item) => item.product.id == product.id,
                            orElse: () =>
                                CartItem(product: product, quantity: 0),
                          );

                          return cartItem.quantity > 0
                              ? Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.remove,
                                            color: Colors.red),
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .removeItem(product);
                                        }),
                                    Text(
                                      '${cartItem.quantity}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add,
                                          color: Colors.green),
                                      onPressed: () {
                                        context
                                            .read<CartCubit>()
                                            .addItem(product);
                                      },
                                    ),
                                  ],
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    context.read<CartCubit>().addItem(product);
                                    final snackBar = returnSnack(
                                        '${product.title} added to cart');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
