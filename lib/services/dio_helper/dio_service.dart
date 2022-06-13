import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    String baseUrl = 'https://fqrgneoixh.execute-api.us-east-1.amazonaws.com/';
    // https://fqrgneoixh.execute-api.us-east-1.amazonaws.com/createWeaponResponse

    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        responseType: ResponseType.plain,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        }));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return dio.post(url, queryParameters: query, data: data);
  }


}