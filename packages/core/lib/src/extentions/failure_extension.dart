import 'package:core/src/constant/app_strings.dart';
import 'package:core/src/failure/failure.dart';

extension FailureExtension on Failure {
  bool get isSuccess => failureType == FailureType.none;
}
extension FailureTypeExtension on Failure {
  String get meaningfulMessage {
    if (failureType == FailureType.networkUnavailable) {
      return "Network request failed. Please check your internet connection.";
    } else if (failureType == FailureType.timeout) {
      return "Server error occurred. Please try again later.";
    } else if (failureType == FailureType.missingData) {
      return "Cache error occurred. Unable to load data.";
    } else if (failureType == FailureType.consentRequired) {
      return "Authentication failed. Please check your credentials.";
    }else if (failureType == FailureType.customMessage) {
      return (this as GeneralFailure).additionalData.toString();
    } else if (failureType == FailureType.exception) {
      return (this as ExceptionFailure).exception.toString();
    } else if (failureType == FailureType.httpStatus) {
      return (this as GeneralFailure).additionalData["message"];
    } else if (failureType == FailureType.networkUnavailable) {
      return AppStrings.strNoInternetError;
    } else if (failureType == FailureType.invalidToken) {
      return "Invalid Login credentials";
    } else {
      return AppStrings.strUnknownError;
    }
  }
}

