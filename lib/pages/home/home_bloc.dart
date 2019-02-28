import 'dart:async';

import 'package:exata_questoes_app/models/api/materia_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/pages/quiz/quiz_page.dart';
import 'package:exata_questoes_app/services/ano/ano_service.dart';
import 'package:exata_questoes_app/services/materia/materia_service.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class HomeBloc {
  SimuladoService _simuladoService;
  AnoService _anoService;
  MateriaService _materiaService;
  QuestaoService _questaoService;
  FiltroModel _filtro;

  final _simulados = BehaviorSubject<List<SimuladoModel>>();
  final _anos = BehaviorSubject<List<String>>();
  final _materias = BehaviorSubject<List<MateriaModel>>();
  final _loadingSimulados = BehaviorSubject<bool>();
  final _loadingAnos = BehaviorSubject<bool>();
  final _loadingMaterias = BehaviorSubject<bool>();
  final _loadingQuestoes = BehaviorSubject<bool>();

  Stream<List<String>> get anos => _anos.stream;
  Stream<List<SimuladoModel>> get simulados => _simulados.stream;
  Stream<List<MateriaModel>> get materias => _materias.stream;
  Stream<bool> get loadingSimulados => _loadingSimulados.stream;
  Stream<bool> get loadingAnos => _loadingAnos.stream;
  Stream<bool> get loadingMaterias => _loadingMaterias.stream;
  Stream<bool> get loadingQuestoes => _loadingQuestoes.stream;

  List<SimuladoModel> _simuladosList;

  HomeBloc(this._simuladoService, this._anoService, this._materiaService,
      this._questaoService) {
    _filtro = FiltroModel();
    onRefresh();
  }

  Future<Null> onRefresh() async {
    _filtro = FiltroModel();
    _loadSimulados();
    _loadAnos();
    _loadMaterias();

    return null;
  }

  void _loadSimulados() async {
    _loadingSimulados.add(true);

    var result = await _simuladoService.getSimuladosAsync();
    if (result.success) {
      _simuladosList = result.data;
      _simulados.add(result.data);
    } else {
      _simulados.addError(result.errors);
    }

    _loadingSimulados.add(false);
  }

  void _loadAnos() async {
    _loadingAnos.add(true);

    var result = await _anoService.getAnosAsync();
    if (result.success) {
      _anos.add(result.data);
    } else {
      _anos.addError(result.errors);
    }

    _loadingAnos.add(false);
  }

  void _loadMaterias() async {
    _loadingMaterias.add(true);

    final result = await _materiaService.getMateriasAsync();
    if (result.success) {
      _materias.add(result.data);
    } else {
      _materias.addError(result.errors);
    }

    _loadingMaterias.add(false);
  }

  void onLoadQuestoes(BuildContext context) async {
    _loadingQuestoes.add(true);

    final response = await _questaoService.getQuestoesAsync(_filtro);
    if (response.success) {
      if (response.data.length == 0) {
        final snackbar = SnackBar(
            content: Text("Nenhuma questão encontrada com o filtro aplicado"));
        Scaffold.of(context).showSnackBar(snackbar);
      } else {
        final questoes = response.data;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuizPage(
                bloc: kiwi.Container().resolve(),
                filtro: _filtro,
                simulado: SimuladoModel(id: -1, nome: "Treinamento", questoes: questoes),
                isHardcoreMode: false)));
      }
    } else {
      final snackbar = SnackBar(content: Text(response.errors.first));
      Scaffold.of(context).showSnackBar(snackbar);
    }

    _loadingQuestoes.add(false);
  }

  void onSelectSimulado(BuildContext context, SimuladoModel simulado) async {
    _loadingQuestoes.add(true);

    final response = await _simuladoService.getSimuladoAsync(simulado.id);
    if (response.success) {
      simulado = response.data;
      final route = MaterialPageRoute(
        builder: (context) => QuizPage(
          simulado: simulado,
          filtro: null,
          bloc: kiwi.Container().resolve(),
          isHardcoreMode: true,
        )
      );
      Navigator.of(context).push(route);

    } else {
      final snackbar = SnackBar(content: Text(response.errors.first));
      Scaffold.of(context).showSnackBar(snackbar);
    }

    _loadingQuestoes.add(false);
  }

  void onSearchSimulado(String query) {
    final simulados = _simuladosList.where((s) => s.nome.contains(query)).toList();
    _simulados.add(simulados);
  }

  void onClearSimuladoSearch() => _simulados.add(_simuladosList);

  void onAddMateria(bool wasAdded, MateriaModel materia) {
    wasAdded
        ? _filtro.materias.add(materia.id)
        : _filtro.materias.remove(materia.id);
  }

  void onAddAno(bool wasAdded, String ano) {
    wasAdded ? _filtro.anos.add(ano) : _filtro.anos.remove(ano);
  }

  void dispose() {
    _simulados.close();
    _anos.close();
    _materias.close();
    _loadingSimulados.close();
    _loadingAnos.close();
    _loadingMaterias.close();
    _loadingQuestoes.close();
  }
}
