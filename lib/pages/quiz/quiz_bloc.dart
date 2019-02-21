import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {
  QuestaoService _questaoService;
  FiltroModel _filtro;
  PageController pageController;
  Map<int, bool> _questaoMap;
  static const adInterval = 5;

  final _questoes = BehaviorSubject<List<QuestaoModel>>();
  final _questoesRespondidasMap = BehaviorSubject<Map<int, bool>>();

  Stream<List<QuestaoModel>> get questoes => _questoes.stream;
  Stream<Map<int, bool>> get questoesRespondidasMap =>
      _questoesRespondidasMap.stream;

  QuizBloc(this._questaoService) {
    pageController = PageController();
    _questaoMap = Map<int, bool>();
  }

  void setup(List<QuestaoModel> initialQuestions, FiltroModel filtro) {
    initialQuestions.forEach((questao) {
      _questaoMap[questao.id] = false;
    });
    _questoesRespondidasMap.add(_questaoMap);
    _questoes.add(initialQuestions);
    this._filtro = filtro;
  }

  int calculatePageCount() {
    final totalQuestions = _questoes.value.length;
    final numberOfAds = (totalQuestions / adInterval).floor() - 1;
    return totalQuestions;
  }

  void onPageChanged(int index) {}

  void onAlternativaSelected(int questaoId) {
    _questaoMap[questaoId] = true;
    _questoesRespondidasMap.add(_questaoMap);
  }

  void dispose() {
    _questoes.close();
    _questoesRespondidasMap.close();
  }
}
