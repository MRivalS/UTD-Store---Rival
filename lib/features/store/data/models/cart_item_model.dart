import '../../domain/entities/product_entity.dart';

class CartItem {
  final dynamic product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
