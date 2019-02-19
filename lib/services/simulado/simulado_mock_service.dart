import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/api/response/response_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';

class SimuladoMockService implements SimuladoService {
  @override
  Future<ResponseModel<SimuladoModel>> getSimuladoAsync() async {
    await Future.delayed(Duration(seconds: 3));
    var data = SimuladoModel(id: 1, nome: "Enem 2018");

    return ResponseModel.success(data);
  }

  @override
  Future<ResponseListModel<SimuladoModel>> getSimuladosAsync() async {
    await Future.delayed(Duration(seconds: 3));
    var data = [
      SimuladoModel(id: 1, nome: "Enem 2018"),
      SimuladoModel(id: 2, nome: "Enem 2017"),
      SimuladoModel(id: 3, nome: "Enem 2016"),
    ];

    return ResponseListModel.success(data);
  }
}
