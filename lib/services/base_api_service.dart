import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wake/services/api_service/base_url.dart';

class BaseApiService {
  // final EncryptionService encrypton = EncryptionService();
  // AppStorageService secureStorage = AppStorageService();

  Dio _dio({required Map<String, dynamic> headers}) {
    return Dio(
      BaseOptions(
          baseUrl: AppBaseUrl.baseUrl,
          headers: headers,
          responseType: ResponseType.plain),
    )..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            options.headers = headers;
            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response?.statusCode == 401) {
              // RefreshedTokenModel? newAccessToken =
              //     await refreshLoggedInUserToken();

              // e.requestOptions.headers['Authorization'] =
              //     'Bearer ${newAccessToken.accessToken}';

              return handler.resolve(await Dio().fetch(e.requestOptions));
            }
            return handler.next(e);
          },
        ),
      );
  }

  // Future<dynamic> postRequest(var url, dynamic payload) async {
  //   Map<String, dynamic> headers = {
  //     'Authorization': 'Bearer ${await secureStorage.getUserToken}',
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   log("url: $url");
  //   log("Payload: ${json.encode(payload)}");

  //   //Make Request
  //   final Response<dynamic> res =
  //       await _dio(headers: headers).post<dynamic>(url, data: payload);

  //   log("response: $res");

  //   return res;
  // }

  // Future<dynamic> putRequest(var url, dynamic payload) async {
  //   Map<String, dynamic> headers = {
  //     'Authorization': 'Bearer ${await secureStorage.getUserToken}',
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   log("url: $url");
  //   log("Payload: ${json.encode(payload)}");

  //   //Make Request
  //   final Response<dynamic> res =
  //       await _dio(headers: headers).put<dynamic>(url, data: payload);

  //   log("response: $res");

  //   return res;
  // }

  // Future<dynamic> deleteRequest({
  //   required String url,
  // }) async {
  //   log("url: $url");

  //   Map<String, dynamic> headers = {
  //     'Authorization': 'Bearer ${await secureStorage.getUserToken}',
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   final Response<dynamic> res =
  //       await _dio(headers: headers).delete<dynamic>(url);

  //   log("response: $res");

  //   return res;
  // }

  // Future<dynamic> getRequest({required String url}) async {
  //   log("url: $url");

  //   Map<String, dynamic> headers = {
  //     'Authorization': 'Bearer ${await secureStorage.getUserToken}',
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   };

  //   final Response<dynamic> res =
  //       await _dio(headers: headers).get<dynamic>(url);

  //   log("response: $res");

  //   return res;
  // }

  /* No Authentication request */

  Future<dynamic> postRequestNoAuth(var url, dynamic payload) async {
    Map<String, String> headersNoAuth = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    log("url: $url");
    log("Payload: ${json.encode(payload)}");

    //Make Request
    final Response<dynamic> res =
        await _dio(headers: headersNoAuth).post<dynamic>(url, data: payload);

    log("response: $res");

    return res;
  }

  Future<dynamic> putRequestNoAuth(var url, dynamic payload) async {
    Map<String, String> headersNoAuth = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    log("url: $url");
    log("Payload: ${json.encode(payload)}");

    //Make Request
    final Response<dynamic> res =
        await _dio(headers: headersNoAuth).put<dynamic>(url, data: payload);

    log("response: $res");

    return res;
  }

  Future<dynamic> getRequestNoAuth(var url) async {
    Map<String, String> headersNoAuth = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Response<dynamic> res =
        await _dio(headers: headersNoAuth).get<dynamic>(url);

    log("response: $res");

    return res;
  }

  // Future<RefreshedTokenModel> refreshLoggedInUserToken() async {
  //   Map<String, dynamic> payload = {
  //     "accessToken": await secureStorage.getUserToken,
  //   };

  //   var url = '${AppBaseUrl.baseUrl}/api/Account/refresh-token';
  //   final jsonResponse = await postRequestNoAuth(url, payload);
  //   if (jsonResponse["responsecode"] == "00") {
  //     secureStorage.saveUserToken(jsonResponse["accessToken"]);

  //     return RefreshedTokenModel(
  //         isRefreshed: true, expires: jsonResponse["expires"]);
  //   } else {
  //     return RefreshedTokenModel(isRefreshed: false, expires: null);
  //   }
  // }
}
