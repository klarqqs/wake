import 'package:dio/dio.dart';

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  factory CustomException.fromDioError(DioException error) {
    if (error.response != null) {
      // The request was made and the server responded with a non-2xx status code
      return CustomException(error.response?.data['message'] ?? error.message);
    } else {
      // Something went wrong in setting up or sending the request
      return CustomException(error.message!);
    }
  }

  @override
  String toString() {
    return 'CustomException: $message';
  }
}

// general methods:------------------------------------------------------------
String handleError(DioError error) {
  String errorDescription = '';
  switch (error.type) {
    case DioExceptionType.cancel:
      errorDescription = "";
      break;
    case DioExceptionType.connectionTimeout:
      errorDescription =
          "Connection timed out. Please check your internet connection and try again.";
      break;
    case DioExceptionType.sendTimeout:
      errorDescription =
          "Request timed out while sending data. Please try again.";
      break;
    case DioExceptionType.unknown:
      errorDescription = "An unknown error occurred. Please try again later.";
      break;
    case DioExceptionType.connectionError:
      errorDescription =
          "Unable to establish a connection with the server. Please check your internet connection and try again.";
      break;
    case DioExceptionType.receiveTimeout:
      errorDescription =
          "Request timed out while waiting for a response. Please try again.";
      break;

    default:
      errorDescription = "An unknown error occurred. Please try again later.";
      break;
  }

  return errorDescription;
}
