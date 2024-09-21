import 'package:campus_haat/cubit/product_state.dart';
import 'package:campus_haat/services/campus_haat_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;

  ProductCubit(this.apiService) : super(ProductState());

  void fetchProducts() async {
    emit(ProductState(isLoading: true));

    try {
      final productsListResponse = await apiService.fetchProducts();

      if (productsListResponse != null) {
        emit(ProductState(products: productsListResponse.products));
      } else {
        emit(ProductState(errorMessage: 'Failed to parse products'));
      }
    } catch (e) {
      emit(ProductState(errorMessage: e.toString()));
    }
  }
}
