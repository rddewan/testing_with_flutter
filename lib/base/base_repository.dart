

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:youtube_sample_app/core/error/failure.dart';


mixin BaseRepository {

  Future<T> call<T>(FutureOr<T> Function() call) async  {
    try {

      return await call();

    } on DioError catch (e,s){

      if (e.error is SocketException) {
        throw Failure(message: e.message, stackTrace: s);
      }      
      
      throw Failure(
          message: e.response?.statusMessage ?? 'Something went wrong',
          code: e.response?.statusCode,
          exception: e,
          stackTrace: s,
      );
    }
  }

}