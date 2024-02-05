import 'package:dio/dio.dart';
import 'package:faculty_app/network/api_interceptor.dart';
import 'package:faculty_app/utils/user.dart';


class ApiProvider {
  Dio? _dio;

  //todo change to live base url

  static String baseUrl = 'https://cocoalabs.in/VettedProfilesHub/public/';

  //static String baseUrl = 'https://9a6a-117-201-131-18.ngrok.io/';

  ApiProvider() {
    BaseOptions options;
    options = new BaseOptions(
      baseUrl: baseUrl,

      // receiveTimeout: 10000,
      // connectTimeout: 10000,
    );

    _dio = Dio(options);
    _dio!.interceptors.add(ApiInterceptor());
  }

  Dio getJsonInstance() {
    _dio!.options.headers.addAll({"Content-Type": "application/json"});
    return _dio!;
  }

  Dio getMultipartInstance() {
    _dio!.options.headers.addAll({"Content-Type": "multipart/form-data"});
    return _dio!;
  }

  Dio getJsonInstanceAuth() {
    _dio!.options.headers.addAll({
       "authorization": "Bearer  ${UserDetails.apiToken}",
    });
    return _dio!;
  }
}
