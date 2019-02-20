import 'package:exata_questoes_app/models/api/questao_model.dart';
import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/filtro_model.dart';

abstract class QuestaoService {
  Future<ResponseListModel<QuestaoModel>> getQuestoesAsync(FiltroModel filtro);
  Future<ResponseListModel<QuestaoModel>> getNextPageQuestoesAsync(String nextPageUrl);
}