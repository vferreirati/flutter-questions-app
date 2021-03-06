import 'package:exata_questoes_app/models/api/alternativa_model.dart';
import 'package:exata_questoes_app/models/api/banca_model.dart';
import 'package:exata_questoes_app/models/api/materia_model.dart';
import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';

class QuestaoMockService implements QuestaoService {

  @override
  Future<ResponseListModel<QuestaoModel>> getNextPageQuestoesAsync(String nextPageUrl) async {
    await Future.delayed(Duration(seconds: 2));
    var data = _generateQuestions();
    return ResponseListModel.success(data);
  }

  @override
  Future<ResponseListModel<QuestaoModel>> getQuestoesAsync(FiltroModel filtro) async {
    await Future.delayed(Duration(seconds: 2));
    var data = _generateQuestions();
    return ResponseListModel.success(data);
  }

  List<QuestaoModel> _generateQuestions() {
    return List<QuestaoModel>.generate(20, (index) {
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