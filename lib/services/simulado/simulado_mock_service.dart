import 'package:exata_questoes_app/models/api/alternativa_model.dart';
import 'package:exata_questoes_app/models/api/banca_model.dart';
import 'package:exata_questoes_app/models/api/materia_model.dart';
import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/api/response/response_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';

class SimuladoMockService implements SimuladoService {
  @override
  Future<ResponseModel<SimuladoModel>> getSimuladoAsync(int simuladoId) async {
    await Future.delayed(Duration(seconds: 3));
    try {
      final data = _generateSimulados().firstWhere((simulado) => simulado.id == simuladoId);
      return ResponseModel.success(data);
    } catch (e) {
      return ResponseModel.requestError();
    }
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

  List<SimuladoModel> _generateSimulados() {
    return List<SimuladoModel>.generate(5, (index) {
      return SimuladoModel(
        id: index,
        nome: "ENEM ${2018 + index}",
        questoes: _generateQuestions()
      );
    });
  }

  List<QuestaoModel> _generateQuestions() {
    return List<QuestaoModel>.generate(5, (index) {
      return QuestaoModel(
          id: index,
          enunciado: "Questao com ID: $index",
          ano: (2019 - index).toString(),
          banca: BancaModel(id: 1, nome: "ENEM"),
          materia: MateriaModel(id: index, nome: "Materia $index"),
          alternativas: [
            AlternativaModel(id: 1, corpo: "Alternativa A", correta: true),
            AlternativaModel(id: 2, corpo: "Alternativa B", correta: false),
            AlternativaModel(id: 3, corpo: "Alternativa C", correta: false),
            AlternativaModel(id: 4, corpo: "Alternativa D", correta: false),
            AlternativaModel(id: 5, corpo: "Alternativa E", correta: false)
          ],
          explicacao: null
      );
    });
  }
}
