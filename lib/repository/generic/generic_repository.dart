import 'dart:convert';
import 'dart:typed_data';

import 'package:brinquedoteca_flutter/utils/singleton.dart';
import 'package:dio/dio.dart';

import 'dio_client.dart';

class GenericRepository<T> {
  final String endpoint;
  final T Function(Map<String, dynamic>) fromJson;
  final String? baseUrl;

  GenericRepository({
    required this.endpoint,
    required this.fromJson,
    this.baseUrl,
  });

  Dio get _dio => DioClient(baseUrl: baseUrl).dio;

  Future<List<T>> getAll({Map<String, dynamic>? filters}) async {
    print(_cleanFilters(filters));
    final response = await _dio.get(
      endpoint,
      queryParameters: _cleanFilters(filters),
    );
    final data = response.data as List;
    return data.map((item) => fromJson(item)).toList();
  }

  Future<T> getById(dynamic id) async {
    final response = await _dio.get('$endpoint/$id');
    return fromJson(response.data);
  }

  Future<T> get() async {
    print('$baseUrl$endpoint');
    final response = await _dio.get(endpoint);
    return fromJson(response.data);
  }

  Future<List<T>> search({
    required Map<String, dynamic> filters,
    int? limit,
    int? offset,
    String? orderBy,
    bool? descending,
  }) async {
    final queryParams = _cleanFilters(filters);

    final response = await _dio.get(
      '$endpoint/search',
      queryParameters: queryParams,
    );
    final data = response.data as List;
    return data.map((item) => fromJson(item)).toList();
  }

  Future<T> create(Map<String, dynamic> body) async {
    print(jsonEncode(body));
    final response = await _dio.post(
      endpoint,
      data: jsonEncode(body),
    );
    return fromJson(response.data);
  }

  Future<T> update(dynamic id, Map<String, dynamic> body) async {
    final response = await _dio.put(
      '$endpoint/$id',
      data: body,
    );
    return fromJson(response.data);
  }

  Future<void> delete(dynamic id) async {
    await _dio.delete('$endpoint/$id');
  }

  Future<Response> uploadFile({
    required String pathField,
    required String filename,
    required Uint8List fileBytes,
    String fieldName = 'imagem',
    String formFieldName = 'pasta',
    String uploadEndpoint = '/upload',
  }) async {
    final formData = FormData.fromMap({
      formFieldName: "${Singleton.instance.tenant}/$pathField",
      fieldName: MultipartFile.fromBytes(
        fileBytes,
        filename: filename,
      ),
    });

    final response = await _dio.post(uploadEndpoint, data: formData);
    return response;
  }

  Map<String, dynamic> _cleanFilters(Map<String, dynamic>? filters) {
    if (filters == null) return {};
    return filters.map((key, value) {
      if (value == null) {
        return MapEntry(key, "null"); // força ?ch.data_saida=null
      }
      return MapEntry(key, value);
    });
  }

}