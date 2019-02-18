class SimuladoModel {
  int id;
  String nome;

  SimuladoModel({this.id, this.nome});

  static SimuladoModel fromJson(Map<String, dynamic> json) {
    var model = SimuladoModel();

    model.id = json["id"];
    model.nome = json["nome"];

    return model;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["id"] = this.id;
    map["nome"] = this.nome;

    return map;
  }
}
