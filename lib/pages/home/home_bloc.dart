import 'dart:async';

import 'package:exata_questoes_app/models/api/materia_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';
import 'package:exata_questoes_app/services/ano/ano_mock_service.dart';
import 'package:exata_questoes_app/services/ano/ano_service.dart';
import 'package:exata_questoes_app/services/materia/materia_mock_service.dart';
import 'package:exata_questoes_app/services/materia/materia_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_mock_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  SimuladoService _simuladoService;
  AnoService _anoService;
  MateriaService _materiaService;
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

  HomeBloc() {
    _simuladoService = SimuladoMockService();
    _anoService = AnoMockService();
    _materiaService = MateriaMockService();
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
      _simulados.add(result.data);
    } else {
      _simulados.addError(result.errors);
    }

    _loadingSimulados.add(false);
  }

  void onSelectSimulado(SimuladoModel simulado) {
    _loadingQuestoes.add(true);
    print("O simulado escolhido foi ${simulado.nome}:${simulado.id}");

    Future.delayed(Duration(seconds: 2));

    _loadingQuestoes.add(false);
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

  void onLoadQuestoes() async {
    _loadingQuestoes.add(true);

    print(
        "Buscando questões das materias: ${_filtro.materias}\nBuscando questões dos anos: ${_filtro.anos}");
    await Future.delayed(Duration(seconds: 2));

    _loadingQuestoes.add(false);
  }

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
