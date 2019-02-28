import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/services/ano/ano_service.dart';

class AnoMockService implements AnoService {
  Future<ResponseListModel<String>> getAnosAsync() async {
    await Future.delayed(Duration(seconds: 3));

    var data = ["2019", "2018", "2017", "2016", "2015"];

    return ResponseListModel.success(data);
  }
}
