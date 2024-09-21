import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

class OrderCompletePage extends StatefulWidget {
  const OrderCompletePage({super.key});

  @override
  State<OrderCompletePage> createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToCartPage();
  }

  void _navigateToCartPage() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/Animation - 1726741431798.json',
          width: 370,
          height: 370,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
