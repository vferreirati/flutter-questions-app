import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/pages/result/result_page.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {
  QuestaoService _questaoService;

  PageController pageController;
  TextEditingController errorTextController;

  static const adInterval = 5;

  List<RespostaModel> _respostasList;

  SimuladoModel _simulado;

  BuildContext _pageContext;

  int _indiceQuestaoAtual;

  final _questoes = BehaviorSubject<List<QuestaoModel>>();
  final _respostas = BehaviorSubject<List<RespostaModel>>();

  Stream<List<QuestaoModel>> get questoes => _questoes.stream;
  Stream<List<RespostaModel>> get respostas => _respostas.stream;

  QuizBloc(this._questaoService) {
    pageController = PageController();
    _respostasList = List<RespostaModel>();
    errorTextController = TextEditingController();
  }

  void setup({BuildContext context, SimuladoModel simulado}) {
    _pageContext = context;
    _simulado = simulado;
    _questoes.add(simulado.questoes);
    _respostas.add(_respostasList);
    _indiceQuestaoAtual = 0;
  }

  void onPageChanged(int index) {
    _indiceQuestaoAtual = index;
  }

  void onAlternativaSelected(int questaoId, int alternativaId) {
    var resposta = _respostasList
        .firstWhere((resp) => resp.questaoId == questaoId, orElse: () => null);
    if (resposta == null) {
      print(
          "Questão não respondida previamente, adicionando resposta do usuário");
      _respostasList.add(
          RespostaModel(questaoId: questaoId, alternativaId: alternativaId));
      _respostas.add(_respostasList);
    } else {
      print(
          "Questão já respondida previamente, atualizando resposta do usuário");
      resposta.alternativaId = alternativaId;
      _respostasList[_respostasList.indexWhere(
          (resposta) => resposta.questaoId == questaoId)] = resposta;
    }
    _respostas.add(_respostasList);
  }

  void verificarQuestoesRespondidas() {
    final listaRespostas = _respostas.value;
    final listaQuestoes = _questoes.value;

    if(listaQuestoes.length == listaRespostas.length) {
      print("Todas as questões foram respondidas, abrir pagina de resultado");
      final route = MaterialPageRoute(
        builder: (context) => ResultPage(
          simulado: _simulado,
          respostas: _respostasList,
        )
      );
      Navigator.of(_pageContext).push(route);

    } else {
      print("Ainda faltam ${listaQuestoes.length - listaRespostas.length} questões a serem respondidas");
    }
  }

  bool questaoFoiRespondida(int questaoId) => _respostas.value.firstWhere((resp) => resp.questaoId == questaoId, orElse: () => null) != null;

  void onErrorSubmit(BuildContext context) {
    final snackbar =
        SnackBar(content: Text("Erro na questão informado com sucesso"));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  bool isLastPage(int index) => index == _questoes.value.length;

  void dispose() {
    _questoes.close();
    _respostas.close();
  }
}

class RespostaModel {
  int questaoId;
  int alternativaId;

  RespostaModel({this.questaoId, this.alternativaId});
  @override
  String toString() {
    return this.questaoId.toString();
  }
}
