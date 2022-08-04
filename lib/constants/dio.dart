import 'package:dio/dio.dart';

class MyDio {
  static const baseUrl = 'https://linkie-server.herokuapp.com/api'; //heroku
  static BaseOptions options = BaseOptions(baseUrl: baseUrl);

  static Future<Dio> provideDio() async {
    final Dio dio = Dio(options);
    return dio;
  }
}
