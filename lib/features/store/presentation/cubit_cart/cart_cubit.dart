import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addToCart(dynamic product) {
    final currentState = List<CartItem>.from(state);
    int index = currentState.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (index != -1) {
      currentState[index].quantity += 1;
    } else {
      currentState.add(CartItem(product: product));
    }
    emit(currentState);
  }
  void removeFromCart(int productId) {
    final currentState = List<CartItem>.from(state);
    currentState.removeWhere((item) => item.product.id == productId);
    emit(currentState);
  }
}
