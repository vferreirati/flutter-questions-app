import 'package:exata_questoes_app/models/api/response/response_list_model.dart';
import 'package:exata_questoes_app/models/materia_model.dart';
import 'package:exata_questoes_app/services/materia/materia_service.dart';

class MateriaMockService implements MateriaService {

  Future<ResponseListModel<MateriaModel>> getMateriasAsync() async {
    await Future.delayed(Duration(seconds: 1));

    final data = [
      MateriaModel(id: 1, nome: "Português"),
      MateriaModel(id: 2, nome: "Matemática"),
      MateriaModel(id: 3, nome: "Física"),
      MateriaModel(id: 4, nome: "Química")
    ];

    return ResponseListModel.success(data);
  }
}