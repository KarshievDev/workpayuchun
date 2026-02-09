import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

abstract class HttpService{

  void init();

  Future<Response?> getRequest(String url);
  Future<Either<Failure, Response>> getRequestWithToken(String url,{String token});
  Future<Response?> deleteRequest(String url);
  Future<Either<Failure, Response>> postRequest(String url,body);
}