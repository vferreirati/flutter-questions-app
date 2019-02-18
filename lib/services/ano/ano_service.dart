import 'package:exata_questoes_app/models/api/response/response_list_model.dart';

abstract class AnoService {
  Future<ResponseListModel<String>> getAnosAsync();
}
