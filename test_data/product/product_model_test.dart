
import 'package:youtube_sample_app/features/product/domain/model/page.dart';
import 'package:youtube_sample_app/features/product/domain/model/product.dart';
import 'package:youtube_sample_app/features/product/domain/model/product_model.dart';

import 'product_response_test.dart';

Future<ProductModel> getProductModelTest() async {
  const   baseUrl = 'https://bazar.rdewan.dev';
  final response = await getProductResponseTest();
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
            thumbnail: '$baseUrl${e.thumbnail}', 
            images: '$baseUrl${e.images}', 
            isActive: int.parse(e.isActive),                   
          ),    
        ).toList(),
      );  
}