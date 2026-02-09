import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:dio_service/dio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tf_dio_cache/tf_dio_cache.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

class HttpServiceImpl implements HttpService {
  late Dio? _dio;
  late DioCacheManager _manager;

  HttpServiceImpl() {
    init();
  }

  @override
  Future<Response> getRequest(String url) async {
    Response response;

    try {
      response = await _dio!.get(url);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        debugPrint('unAuthentication');
        throw UnAuthenticationException();
      } else {
        debugPrint(e.message);
        throw Exception(e.message);
      }
    }

    return response;
  }

  @override
  Future<Either<Failure, Response>> getRequestWithToken(String url,
      {contentType = 'application/json', String? token}) async {
    try {
      final response = await _dio!.get(url, options: _buildCacheOptions(tkn: token));
      return Right(response);
    } on DioException catch (e) {
      String? additionalData;
      try {
        if (e.response != null && e.response!.data != null) {
          if (e.response!.data is Map) {
            additionalData = e.response!.data!['Title'];
          } else {
            additionalData = e.response!.data;
          }
        }
      } catch (e) {
        additionalData = null;
      }
      if (e.response != null) {
        // The status code 404 not found has special significance to some methods. See if we are here because
        // of a 404 and if so, return a special failure.
        if (e.response!.statusCode == HttpStatus.notFound) {
          if (e.response!.data is Map<String, dynamic>) {
            final jsonMap = e.response!.data;
            if (jsonMap['message'] != null) {
              final message = jsonMap['message'] as String;
              if (message.toLowerCase().contains('consent required')) {
                return const Left(GeneralFailure.consentRequired());
              }
            }
            return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', jsonMap['message']));
          }
          return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', 'Unauthenticated'));
        } else if (e.response!.statusCode == HttpStatus.badRequest) {
          if (e.response!.data is Map<String, dynamic>) {
            final jsonMap = e.response!.data;
            if (jsonMap['message'] != null) {
              final message = jsonMap['message'] as String;
              if (message.toLowerCase().contains('no eligible accounts found')) {
                return const Left(GeneralFailure.ineligible());
              }
            }
            return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', jsonMap['message']));
          }
          return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', 'Bad request'));
        } else if (e.response!.statusCode == HttpStatus.unauthorized) {
          return const Left(GeneralFailure.invalidToken());
        }
      }
      return Left(ExceptionFailure(exception: e, additionalData: additionalData));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  @override
  void init() {
    _dio = Dio();
    _dio!.interceptors.add(_getCacheManager().interceptor);
    _dio!.interceptors.add(RetryOnConnectionInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(dio: _dio, connectivity: Connectivity())));
  }

  DioCacheManager _getCacheManager() {
    _manager = DioCacheManager(CacheConfig(baseUrl: rootUrl));
    return _manager;
  }

  Options _buildCacheOptions({String? tkn}) {
    return buildCacheOptions(const Duration(days: 3),
        maxStale: const Duration(days: 1),
        forceRefresh: true,
        options: Options(
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
            'Charset': 'utf-8',
            'Accept' : 'application/json',
            "Authorization": "Bearer ${tkn ?? globalState.get(authToken)}"
          },
        ));
  }

  @override
  Future<Either<Failure, Response>> postRequest(String url, body,
      {contentType = 'application/json;charset=UTF-8'}) async {
    try {
      final response = await _dio!.post(url, data: body, options: _buildCacheOptions());
      return Right(response);
    } on DioException catch (e) {
      String? additionalData;
      try {
        if (e.response != null && e.response!.data != null) {
          if (e.response!.data is Map) {
            additionalData = e.response!.data!['Title'];
          } else {
            additionalData = e.response!.data;
          }
        }
      } catch (e) {
        additionalData = null;
      }
      if (e.response != null) {
        // The status code 404 not found has special significance to some methods. See if we are here because
        // of a 404 and if so, return a special failure.
        if (e.response!.statusCode == HttpStatus.notFound) {
          if (e.response!.data is Map<String, dynamic>) {
            final jsonMap = e.response!.data;
            if (jsonMap['message'] != null) {
              final message = jsonMap['message'] as String;
              if (message.toLowerCase().contains('consent required')) {
                return const Left(GeneralFailure.consentRequired());
              }
            }
            return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', jsonMap['message']));
          }
          return Left(GeneralFailure.custom('STATUS:${e.response!.statusCode}\n Please try again later'));
        } else if (e.response!.statusCode == HttpStatus.badRequest) {
          if (e.response!.data is Map<String, dynamic>) {
            final jsonMap = e.response!.data;
            if (jsonMap['message'] != null) {
              final message = jsonMap['message'] as String;
              if (message.toLowerCase().contains('no eligible accounts found')) {
                return const Left(GeneralFailure.ineligible());
              }
            }
            return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', jsonMap['message']));
          }
          return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', 'Bad request'));
        } else if (e.response!.statusCode == HttpStatus.unprocessableEntity) {
          if (e.response!.data is Map<String, dynamic>) {
            final jsonMap = e.response!.data;
            if (jsonMap['error'] != null) {
             return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', jsonMap['error'][0]));
            }
            return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', jsonMap['error'][0]));
          }
          return Left(GeneralFailure.httpStatus(e.response!.statusCode ?? 0, 'post', 'Bad request'));
        } else if (e.response!.statusCode == HttpStatus.unauthorized) {
          return const Left(GeneralFailure.invalidToken());
        }
      }
      return Left(ExceptionFailure(exception: DioExceptions.fromDioError(e), additionalData: additionalData));
    } on Exception catch (e) {
      return Left(ExceptionFailure(exception: e));
    }
  }

  @override
  Future<Response> deleteRequest(String url) async {
    Response response;

    try {
      response =
          await _dio!.delete(url, options: Options(headers: {"Authorization": "Bearer ${globalState.get(authToken)}"}));
    } on SocketException {
      throw const SocketException('No internet connection');
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        statusCode = dioError.response!.statusCode!;
        message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.connectionError:
        message = "No internet connection";
        break;
      default:
        message = "Unknown error !! Please try again later";
        break;
    }
  }

  late String message;
  int statusCode = -1;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
