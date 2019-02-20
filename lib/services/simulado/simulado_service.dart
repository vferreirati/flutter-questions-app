import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/api/response/response_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';

abstract class SimuladoService {
  Future<ResponseListModel<SimuladoModel>> getSimuladosAsync();

  Future<ResponseModel<SimuladoModel>> getSimuladoAsync(int simuladoId);
}
