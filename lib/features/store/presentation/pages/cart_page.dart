import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit_cart/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Belanja")),
      body: BlocBuilder<CartCubit, List<dynamic>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty)
            return const Center(child: Text("Keranjang kosong"));

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                leading: Image.network(item.product.image, width: 50),
                title: Text(item.product.title),
                subtitle: Text(
                  "Qty: ${item.quantity} - \$${item.product.price * item.quantity}",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      context.read<CartCubit>().removeFromCart(item.product.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
