import 'dart:async';

import 'package:exata_questoes_app/models/api/simulado_model.dart';
import 'package:exata_questoes_app/services/ano/ano_mock_service.dart';
import 'package:exata_questoes_app/services/ano/ano_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_mock_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';

class QuestionBloc {
  SimuladoService _simuladoService;
  AnoService _anoService;

  final _simulados = StreamController<List<SimuladoModel>>(sync: false);
  final _anos = StreamController<List<String>>();
  final _loadingSimulados = StreamController<bool>();
  final _loadingAnos = StreamController<bool>();

  Stream<List<String>> get anos => _anos.stream;
  Stream<List<SimuladoModel>> get simulados => _simulados.stream;
  Stream<bool> get loadingSimulados => _loadingSimulados.stream;
  Stream<bool> get loadingAnos => _loadingAnos.stream;

  QuestionBloc() {
    _simuladoService = SimuladoMockService();
    _anoService = AnoMockService();

    _loadSimulados();
    _loadAnos();
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

  void dispose() {
    _simulados.close();
    _anos.close();
    _loadingSimulados.close();
    _loadingAnos.close();
  }
}
