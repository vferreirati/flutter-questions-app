import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/api/response/response_model.dart';
import 'package:exata_questoes_app/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

class RequestService {
  Dio _dio;
  Connectivity _connectivity;

  RequestService() {
    _dio = new Dio();
    _dio.options.baseUrl = ServerUrl;
    _connectivity = Connectivity();
  }

  Future<bool> checkConnectivity() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<ResponseListModel<T>> getListAsync<T>(
      {@required String url, @required T Function(Map<String, dynamic>) objectFromJson}) async {
    var isConnected = await checkConnectivity();
    if(isConnected) {
      try {
        var response = await _dio.get(url);
        if(response != null) {
          return ResponseListModel.fromJson<T>(response.data, objectFromJson);

        } else {
          return ResponseListModel.requestError();
        }
      } catch(e) {
        print("Erro: ${e.toString()}");
        return ResponseListModel.requestError();
      }

    } else {
      return ResponseListModel.noConnection();
    }
  }

  Future<ResponseModel<T>> getAsync<T>(
      {@required String url, @required T Function(Map<String, dynamic>) objectFromJson}) async {
    var isConnected = await checkConnectivity();

    if(isConnected) {
      try{
        var response = await _dio.get(url);
        if(response != null) {
          return ResponseModel.fromJson<T>(response.data, objectFromJson);

        } else {
          return ResponseModel.requestError();
        }

      } catch(e) {
        print("Erro: ${e.toString()}");
        return ResponseModel.requestError();
      }

    } else {
      return ResponseModel.noConnection();
    }
  }

  Future<ResponseModel> postAsync<T>({@required String url, @required Map<String, dynamic> json}) async {
    var isConnected = await checkConnectivity();

    if(isConnected) {
      try {
        var response = await _dio.post(url, data: json);
        if(response != null) {
          return ResponseModel.fromJson(response.data, null);

        } else {
          return ResponseModel.requestError();
        }

      } catch(e) {
        print("Erro: ${e.toString()}");
        return ResponseModel.requestError();
      }

    } else {
      return ResponseModel.noConnection();
    }
  }
}
