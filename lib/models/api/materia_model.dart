class MateriaModel {
  int id;
  String nome;

  MateriaModel({this.id, this.nome});

  static MateriaModel fromJson(Map<String, dynamic> json) {
    var model = MateriaModel();

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