import 'dart:io';
import 'package:dio_service/dio_service.dart';
import 'models/token_status.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final String token;
  late HttpServiceImpl _httpServiceImpl;

  UserRepository({required this.token}) {
    _httpServiceImpl = HttpServiceImpl();
  }

  Future<TokenStatus> tokenVerification({
    required String token,
    required String baseUrl,
  }) async {
    String api = 'user/token-alive/$token';
    try {
      final response = await _httpServiceImpl.getRequest('$baseUrl$api');
      if (response.statusCode != 200) {
        return TokenStatus(status: false, code: response.statusCode ?? 400);
      }
      return TokenStatus(status: true, code: response.statusCode ?? 200);
    } on SocketException catch (_) {
      return TokenStatus(status: false, code: -1);
    } on DioException catch (e) {
      if (e is UnAuthenticationException) {
        return TokenStatus(status: false, code: 401);
      }
      return TokenStatus(status: false, code: -1);
    }
  }
}
