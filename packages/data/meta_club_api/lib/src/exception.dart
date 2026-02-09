
///Exception thrown when login failed
class LoginRequestFailure implements Exception{}

///Exception thrown when login failed
class ContactRequestFailure implements Exception{}

///Exception thrown when login failed
class NetworkRequestFailure implements Exception{
  final String message;
  const NetworkRequestFailure(this.message);
}
