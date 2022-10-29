import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/core/provider/base_url_provider.dart';
import 'package:youtube_sample_app/core/remote/network_service_interceptor.dart';


/// Provide the instance of Dio
final networkServiceProvider = Provider.autoDispose<Dio>((ref) {  
  final baseUrl = ref.watch(baseUrlProvider);
      
  final options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 1000 * 60,
    sendTimeout: 1000 * 60,
    receiveTimeout: 1000 * 60,    
  );

  // Add our custom interceptors
  final dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor()
    ]);   
    
  return dio;

});
