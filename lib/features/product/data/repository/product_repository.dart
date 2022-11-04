

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/base/base_repository.dart';
import 'package:youtube_sample_app/common/extension/auto_dispose_cache.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/product/data/api/product_api_service.dart';
import 'package:youtube_sample_app/features/product/data/dto/response/product_response.dart';
import 'package:youtube_sample_app/features/product/data/repository/iproduct_repository.dart';


final productRepositoryProvider = Provider.autoDispose<ProductRepository>((ref) {
  ref.cacheFor(const Duration(seconds: 30)); 
  final productApiService = ref.watch(productApiServiceProvider);

  return ProductRepository(productApiService);
});

class ProductRepository  with BaseRepository implements IProductRepository{
  final ProductApiService _productApiService;

  ProductRepository(this._productApiService);
  
  @override
  Future<ProductResponse> getProducts(Map<String, dynamic> query) async{
    try {

      return await _productApiService.getProducts(query);

    } on DioError catch (e,s){

      if (e.error is SocketException) {
        throw Failure(message: e.message, stackTrace: s);
      }      
      
      throw Failure(
          message: e.response?.data.toString() ?? 'Something went wrong',
          code: e.response?.statusCode,
          exception: e,
          stackTrace: s,
      );
    } 
  }

}