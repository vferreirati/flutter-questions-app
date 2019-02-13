class BancaModel {
  int id;
  String nome;

  BancaModel({this.id, this.nome});

  static BancaModel fromJson(Map<String, dynamic> json) {
    var model = BancaModel()
      ..nome = json["nome"]
      ..id = json["id"];

    return model;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["id"] = this.id;
    map["nome"] = this.nome;

    return map;
  }

  @override
  String toString() {
    return 'BancaModel{id: $id, nome: $nome}';
  }
}