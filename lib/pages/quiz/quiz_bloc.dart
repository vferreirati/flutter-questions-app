import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/pages/result/resultado_page.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {
  QuestaoService _questaoService;

  PageController pageController;
  static const adInterval = 5;
  List<RespostaModel> respostasList;
  List<QuestaoModel> questoesList;
  TextEditingController errorTextController;
  BuildContext _pageContext;
  int _indiceQuestaoAtual;

  final _questoes = BehaviorSubject<List<QuestaoModel>>();
  final _respostas = BehaviorSubject<List<RespostaModel>>();

  Stream<List<QuestaoModel>> get questoes => _questoes.stream;
  Stream<List<RespostaModel>> get respostas => _respostas.stream;

  QuizBloc(this._questaoService) {
    pageController = PageController();
    respostasList = List<RespostaModel>();
    errorTextController = TextEditingController();
  }

  void setup(List<QuestaoModel> initialQuestions, BuildContext context) {
    _pageContext = context;
    questoesList = initialQuestions;
    _questoes.add(questoesList);
    _respostas.add(respostasList);
    _indiceQuestaoAtual = 0;
  }

  void onPageChanged(int index) {
    _indiceQuestaoAtual = index;
  }

  void onAlternativaSelected(int questaoId, int alternativaId) {
    var resposta = respostasList
        .firstWhere((resp) => resp.questaoId == questaoId, orElse: () => null);
    if (resposta == null) {
      print(
          "Questão não respondida previamente, adicionando resposta do usuário");
      respostasList.add(
          RespostaModel(questaoId: questaoId, alternativaId: alternativaId));
      _respostas.add(respostasList);
    } else {
      print(
          "Questão já respondida previamente, atualizando resposta do usuário");
      resposta.alternativaId = alternativaId;
      respostasList[respostasList.indexWhere(
          (resposta) => resposta.questaoId == questaoId)] = resposta;
    }
    _respostas.add(respostasList);
    _verificarQuestoesRespondidas();
  }

  void _verificarQuestoesRespondidas() {
    final listaRespostas = _respostas.value;
    final listaQuestoes = _questoes.value;

    if(listaQuestoes.length == listaRespostas.length) {
      print("Todas as questões foram respondidas, abrir pagina de resultado");
      final route = MaterialPageRoute(
        builder: (context) => ResultPage()
      );
      Navigator.of(_pageContext).push(route);

    } else {
      print("Ainda faltam ${listaQuestoes.length - listaRespostas.length} questões a serem respondidas");
    }
  }

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
