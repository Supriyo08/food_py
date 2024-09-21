import 'package:campus_haat/views/cart_page.dart';
import 'package:campus_haat/views/product_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:campus_haat/views/order_complete_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductListPage(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) {
        return const CartPage();
      },
    ),
    GoRoute(
      path: '/orderComplete',
      builder: (context, state) => const OrderCompletePage(),
    )
  ],
);
