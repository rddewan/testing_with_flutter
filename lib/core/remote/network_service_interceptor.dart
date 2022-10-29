import 'package:dio/dio.dart';



/// NetworkServiceInterceptor will override the onRequest method from  Dio Interceptor class
/// onRequest method will add out custom headers

class NetworkServiceInterceptor extends Interceptor {
  
  NetworkServiceInterceptor();  

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {    
   
    // Read the access token form the secure storage
    const accessToken = null;
    // Read the language code from setting
    const String language = 'th';


    if (accessToken != null) {
      options.headers['Accept'] = 'application/json';
      options.headers['Authorization'] = 'Bearer $accessToken';      
      options.headers['Accept-Language'] = language;
    } else {
      options.headers['Accept'] = 'application/json';     
      options.headers['Accept-Language'] = language;
    }
    
    super.onRequest(options, handler);
  }
  
}
