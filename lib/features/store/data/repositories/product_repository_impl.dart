import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<ProductModel> productModels = await remoteDataSource
        .getProducts();
    final manipulatedProducts = productModels.map((model) {
      return ProductModel(
        id: model.id,
        title: "${model.title} [Promo Ongkir]",
        price: model.price,
        description: model.description,
        category: model.category,
        image: model.image,
      );
    }).toList();
    return manipulatedProducts;
  }
}
