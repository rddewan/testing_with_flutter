

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/base/base_service.dart';
import 'package:youtube_sample_app/common/extension/auto_dispose_cache.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/provider/base_url_provider.dart';
import 'package:youtube_sample_app/features/product/application/iproduct_service.dart';
import 'package:youtube_sample_app/features/product/data/dto/response/product_response.dart';
import 'package:youtube_sample_app/features/product/data/repository/iproduct_repository.dart';
import 'package:youtube_sample_app/features/product/data/repository/product_repository.dart';
import 'package:youtube_sample_app/features/product/domain/mapper/product_odel_mapper.dart';
import 'package:youtube_sample_app/features/product/domain/model/page.dart';
import 'package:youtube_sample_app/features/product/domain/model/product.dart';
import 'package:youtube_sample_app/features/product/domain/model/product_model.dart';

final productServiceProvider = Provider.autoDispose<ProductService>((ref) {
  ref.cacheFor(const Duration(seconds: 30)); 
  final productRepository = ref.watch(productRepositoryProvider);
  final baseUrl = ref.watch(baseUrlProvider);

  return ProductService(productRepository,baseUrl);
  
});

class ProductService with BaseService implements IProductService, ProductModelMapper {
  final IProductRepository _productRepository;
  final String _baseUrl;

  ProductService(this._productRepository, this._baseUrl);

  @override
  Future<Result<Failure, ProductModel>> getProducts(Map<String, dynamic> query) {
    
    final result  = call<Failure, ProductModel>(() async {

      final data = await _productRepository.getProducts(query)
        .then((value) => mapToProductModel(value));

      return Success(data);

    });

    return result;
  }

  @override
  ProductModel mapToProductModel(ProductResponse response) {
    try {
      
      return ProductModel(
        Page(response.currentPage, response.perPage, response.lastPage, response.total), 
        response.data.map((e) => 
          Product(
            id: e.id, 
            categoryId: int.parse(e.categoryId), 
            brandId: int.parse(e.brandId), 
            sku: e.sku,
            name: e.name, 
            shortDescription: e.shortDescription, 
            longDescription: e.longDescription, 
            thumbnail: '$_baseUrl${e.thumbnail}', 
            images: '$_baseUrl${e.images}', 
            isActive: int.parse(e.isActive),          
          ),  
        ).toList(),
      );
    } catch (e) {
      throw Exception(e);
    }
      
  }
  
}