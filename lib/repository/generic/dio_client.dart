import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient({String? baseUrl}) {
    dio = Dio(
      BaseOptions(
        // baseUrl: baseUrl??'http://localhost:5000/',
        baseUrl: baseUrl??'https://api.brinkoo.com.br/',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'tenant': Singleton.instance.tenant
        },
      ),
    );
  }
}
