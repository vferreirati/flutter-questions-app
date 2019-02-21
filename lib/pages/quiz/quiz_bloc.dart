import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {
  QuestaoService _questaoService;
  FiltroModel _filtro;

  final _questoes = BehaviorSubject<List<QuestaoModel>>();

  Stream<List<QuestaoModel>> get questoes => _questoes.stream;

  QuizBloc(this._questaoService);
  
  void setup(List<QuestaoModel> initialQuestions, FiltroModel filtro) {
    _questoes.add(initialQuestions);
    this._filtro = filtro;
  }
  
  void dispose() {
    _questoes.close();
  }
}