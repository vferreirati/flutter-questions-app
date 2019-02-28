import 'package:exata_questoes_app/network/base/request_service.dart';
import 'package:exata_questoes_app/pages/home/home_bloc.dart';
import 'package:exata_questoes_app/pages/quiz/quiz_bloc.dart';
import 'package:exata_questoes_app/services/ano/ano_mock_service.dart';
import 'package:exata_questoes_app/services/ano/ano_service.dart';
import 'package:exata_questoes_app/services/materia/materia_mock_service.dart';
import 'package:exata_questoes_app/services/materia/materia_service.dart';
import 'package:exata_questoes_app/services/questao/questao_mock_service.dart';
import 'package:exata_questoes_app/services/questao/questao_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_mock_service.dart';
import 'package:exata_questoes_app/services/simulado/simulado_service.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.singleton(RequestService)
  @Register.singleton(AnoService, from: AnoMockService)
  @Register.singleton(MateriaService, from: MateriaMockService)
  @Register.singleton(QuestaoService, from: QuestaoMockService)
  @Register.singleton(SimuladoService, from: SimuladoMockService)
  @Register.factory(HomeBloc)
  @Register.factory(QuizBloc)
  void configure();
}

void setup() {
  _$Injector().configure();
}