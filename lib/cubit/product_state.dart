import 'package:campus_haat/models/product_model.dart';

class ProductState {
  final bool isLoading;
  final List<Product>? products;
  final String? errorMessage;

  ProductState({
    this.isLoading = false,
    this.products,
    this.errorMessage,
  });
}
