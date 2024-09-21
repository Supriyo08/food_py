import 'package:campus_haat/cubit/product_cubit.dart';
import 'package:campus_haat/cubit/product_state.dart';
import 'package:campus_haat/navigation/navigation_func.dart';
import 'package:campus_haat/utils/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          NavigationFunc.changePage(value, context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "cart"),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          'Campus Haat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart,
                color: Colors.white), // Add a cart icon
            onPressed: () {
              context.push('/cart');
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
                child: Text(
              state.errorMessage!,
            ));
          }

          if (state.products == null || state.products!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return ListView.builder(
            itemCount: state.products!.length,
            itemBuilder: (context, index) {
              final product = state.products![index];
              final discountPercentage = product.off;
              final price = product.price;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductCard(
                  product: product,
                  discountPercentage: discountPercentage,
                  price: price,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
