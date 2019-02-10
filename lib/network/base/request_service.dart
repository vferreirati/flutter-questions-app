import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/api/response/response_model.dart';
import 'package:exata_questoes_app/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class RequestService {
  Dio _dio;

  RequestService() {
    _dio = new Dio();
    _dio.options.baseUrl = ServerUrl;
  }

  Future<ResponseListModel<T>> getListAsync<T>(
      {@required String url, @required T Function(Map<String, dynamic>) objectFromJson}) async {
    var response = await _dio.get(url);
    if(response != null) {
      return ResponseListModel.fromJson<T>(response.data, objectFromJson);

    } else {
      print("Response is null!");
    }

    return null;
  }

  Future<ResponseModel<T>> getAsync<T>(
      {@required String url, @required T Function(Map<String, dynamic>) objectFromJson}) async {
    var response = await _dio.get(url);

    if(response != null) {
      return ResponseModel.fromJson<T>(response.data, objectFromJson);

    } else {
      print("Response is null!");
    }

    return null;
  }
}
