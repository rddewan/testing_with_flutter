


import 'dart:convert';
import 'dart:io';

import 'package:youtube_sample_app/features/product/data/dto/response/product_response.dart';

Future<ProductResponse> getProductResponseTest() async {
  final response = await File('test_data/product/product_response_test.json').readAsString();
  final Map<String, dynamic>  json = jsonDecode(response);
  
  return ProductResponse.fromJson(json);
}