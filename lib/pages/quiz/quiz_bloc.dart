import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {
  QuestaoService _questaoService;
  
  PageController pageController;
  static const adInterval = 5;
  List<RespostaModel> respostasList;
  List<QuestaoModel> questoesList;

  final _questoes = BehaviorSubject<List<QuestaoModel>>();
  final _respostas = BehaviorSubject<List<RespostaModel>>();

  Stream<List<QuestaoModel>> get questoes => _questoes.stream;
  Stream<List<RespostaModel>> get respostas => _respostas.stream;

  QuizBloc(this._questaoService) {
    pageController = PageController();
    respostasList = List<RespostaModel>();
  }

  void setup(List<QuestaoModel> initialQuestions) {
    questoesList = initialQuestions;
    _questoes.add(questoesList);
    _respostas.add(respostasList);
  }

  int calculatePageCount() {
    final totalQuestions = questoesList.length;
    final numberOfAds = (totalQuestions / adInterval).floor() - 1;
    return totalQuestions;
  }

  void onPageChanged(int index) {

  }

  void onAlternativaSelected(int questaoId, int alternativaId) {
    var resposta = respostasList.firstWhere((resp) => resp.questaoId == questaoId, orElse: () => null);
    if(resposta == null) {
      print("Questão não respondida previamente, adicionando resposta do usuário");
      respostasList.add(RespostaModel(questaoId: questaoId, alternativaId: alternativaId));
      _respostas.add(respostasList);
    } else {
      print("Questão já respondida previamente, atualizando resposta do usuário");
      resposta.alternativaId = alternativaId;
      respostasList[respostasList.indexWhere((resposta) => resposta.questaoId == questaoId)] = resposta;
    }

    print(respostasList);

    _respostas.add(respostasList);
  }

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