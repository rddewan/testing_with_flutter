
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';

final registerRequestValid = RegisterRequest(
  'Demo1', 
  'demo1@gmail.com', 
  '123456abc', 
  '123456abc',
);

final registerRequestInvalid = RegisterRequest(
  'Demo1', 
  'demo1@gmail.com', 
  '123456', 
  '123456',
);