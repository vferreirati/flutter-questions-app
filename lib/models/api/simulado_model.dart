import 'package:exata_questoes_app/models/api/questao_model.dart';

class SimuladoModel {
  int id;
  String nome;
  List<QuestaoModel> questoes;

  SimuladoModel({this.id, this.nome, this.questoes});

  static SimuladoModel fromJson(Map<String, dynamic> json) {
    var model = SimuladoModel();

    model.id = json["id"];
    model.nome = json["nome"];
    model.questoes = (json["questoes"] as List).map((questao) => QuestaoModel.fromJson(questao)).toList();

    return model;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["id"] = this.id;
    map["nome"] = this.nome;
    map["questoes"] = this.questoes.map((questao) => questao.toJson()).toList();

    return map;
  }
}
