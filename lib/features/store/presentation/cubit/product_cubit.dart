import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit({required this.repository}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading()); 
    try {
      final products = await repository.getProducts();
      emit(ProductLoaded(products)); 
    } catch (e) {
      emit(ProductError("Gagal memuat produk. Cek koneksi internet")); // Tampilkan error
    }
  }
}