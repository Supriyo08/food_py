import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationFunc {
  static void changePage(int index, BuildContext context) {
    if (index == 1) {
      context.push('/cart');
    } else {
      context.push('/');
    }
  }
}
