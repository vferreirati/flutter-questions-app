import 'dart:async';

import 'package:exata_questoes_app/models/api/materia_model.dart';
import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/services/ano/ano_mock_service.dart';
import 'package:exata_questoes_app/services/ano/ano_service.dart';
import 'package:exata_questoes_app/services/materia/materia_mock_service.dart';
import 'package:exata_questoes_app/services/materia/materia_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_mock_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';
import 'package:rxdart/rxdart.dart';

class QuestionBloc {
  SimuladoService _simuladoService;
  AnoService _anoService;
  MateriaService _materiaService;

  final _simulados = BehaviorSubject<List<SimuladoModel>>();
  final _anos = BehaviorSubject<List<String>>();
  final _materias = BehaviorSubject<List<MateriaModel>>();
  final _loadingSimulados = BehaviorSubject<bool>();
  final _loadingAnos = BehaviorSubject<bool>();
  final _loadingMaterias = BehaviorSubject<bool>();

  Stream<List<String>> get anos => _anos.stream;
  Stream<List<SimuladoModel>> get simulados => _simulados.stream;
  Stream<List<MateriaModel>> get materias => _materias.stream;
  Stream<bool> get loadingSimulados => _loadingSimulados.stream;
  Stream<bool> get loadingAnos => _loadingAnos.stream;
  Stream<bool> get loadingMaterias => _loadingMaterias.stream;

  QuestionBloc() {
    _simuladoService = SimuladoMockService();
    _anoService = AnoMockService();
    _materiaService = MateriaMockService();

    onRefresh();
  }

  Future<Null> onRefresh() async {
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

  void dispose() {
    _simulados.close();
    _anos.close();
    _materias.close();
    _loadingSimulados.close();
    _loadingAnos.close();
    _loadingMaterias.close();
  }
}
