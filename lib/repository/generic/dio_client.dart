import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient({String? baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl??'http://192.168.234.159:5000/',
        //baseUrl: baseUrl??'https://api.brinkoo.com.br/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'tenant': Singleton.instance.tenant
        },
      ),
    );
  }
}
