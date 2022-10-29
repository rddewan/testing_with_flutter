import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/product/domain/model/product_model.dart';

abstract class IProductService {
  Future<Result<Failure,ProductModel>> getProducts(Map<String,dynamic>  query);
 }