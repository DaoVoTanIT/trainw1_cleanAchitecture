import 'package:dio/dio.dart';

class SendAPI {
  SendAPI(this._dio, this.domain, this.method, this.controller, this.action,
      this.body) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl = "https://" + domain;
  }
  final Dio _dio;
  String baseUrl = '';
  String domain;
  String method;
  String controller;
  String action;
  dynamic body;
  Future<dynamic> sendRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final Response<dynamic> _result =
        await _dio.request('$baseUrl/$controller/$action',
            queryParameters: queryParameters,
            options: Options(
              method: method,
              headers: <String, dynamic>{},
              extra: _extra,
            ),
            data: body);

    if (_result.statusCode != 200) throw Exception('Error call API!');
    return _result.data;
  }

  Future<dynamic> sendRawRequest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final Response<dynamic> _result =
        await _dio.request('$baseUrl/$controller/$action',
            queryParameters: queryParameters,
            options: Options(
              method: method,
              headers: <String, dynamic>{},
              extra: _extra,
            ),
            data: body);
    if (_result.statusCode != 200) throw Exception('Error call API!');
    return _result;
  }
}
