
import 'package:youtube_sample_app/features/product/data/dto/response/product_response.dart';
import 'package:youtube_sample_app/features/product/domain/model/product_model.dart';

abstract class ProductModelMapper {
  ProductModel mapToProductModel(ProductResponse response);
}