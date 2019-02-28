import 'package:exata_questoes_app/models/api/alternativa_model.dart';
import 'package:exata_questoes_app/models/api/banca_model.dart';
import 'package:exata_questoes_app/models/api/materia_model.dart';

class QuestaoModel {
  int id;
  String enunciado;
  String explicacao;
  String ano;
  BancaModel banca;
  MateriaModel materia;
  List<AlternativaModel> alternativas;

  QuestaoModel({this.id, this.enunciado, this.alternativas, this.ano, this.banca, this.explicacao, this.materia});

  static QuestaoModel fromJson(Map<String, dynamic> json) {
    var model = QuestaoModel()
      ..enunciado = json["enunciado"]
      ..id = json["id"]
      ..ano = json["ano"]
      ..explicacao = json["explicacao"]
      ..banca = BancaModel.fromJson(json["banca"])
      ..materia = MateriaModel.fromJson(json["materia"])
      ..alternativas = (json["alternativas"] as List).map((alternativa) => AlternativaModel.fromJson(alternativa)).toList();

    return model;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["id"] = this.id;
    map["enunciado"] = this.enunciado;
    map["ano"] = this.ano;
    map["explicacao"] = this.explicacao;
    map["banca"] = this.banca.toJson();
    map["materia"] = this.materia.toJson();
    map["alternativas"] = this.alternativas.map((alternativa) => alternativa.toJson()).toList();

    return map;
  }

  @override
  String toString() {
    return 'QuestaoModel{id: $id, enunciado: $enunciado, explicacao: $explicacao, ano: $ano, banca: $banca, alternativas: $alternativas}';
  }
}