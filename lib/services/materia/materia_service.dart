import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/materia_model.dart';

abstract class MateriaService {
  Future<ResponseListModel<MateriaModel>> getMateriasAsync();
}