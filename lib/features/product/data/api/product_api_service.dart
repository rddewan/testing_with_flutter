
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youtube_sample_app/common/extension/auto_dispose_cache.dart';
import 'package:youtube_sample_app/core/remote/network_service.dart';
import 'package:youtube_sample_app/features/product/data/dto/response/product_response.dart';

part 'product_api_service.g.dart';

final productApiServiceProvider = Provider.autoDispose<ProductApiService>((ref) {
  ref.cacheFor(const Duration(seconds: 30)); 

  final dio = ref.watch(networkServiceProvider);

  return ProductApiService(dio);
});

@RestApi()
abstract class ProductApiService {
  factory ProductApiService(Dio dio) => _ProductApiService(dio);

  @GET('api/v1/product/getProducts')
  Future<ProductResponse> getProducts(@Queries() Map<String,dynamic>  query);
}