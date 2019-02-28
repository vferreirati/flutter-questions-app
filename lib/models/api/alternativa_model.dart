class AlternativaModel {
  int id;
  String corpo;
  bool correta;

  AlternativaModel({this.corpo, this.correta, this.id});

  static AlternativaModel fromJson(Map<String, dynamic> json) {
    var model = AlternativaModel();

    model.corpo = json["corpo"];
    model.correta = json["correta"];
    model.id = json["id"];

    return model;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["corpo"] = this.corpo;
    map["correta"] = this.correta;
    map["id"] = this.id;

    return map;
  }

  @override
  String toString() {
    return 'AlternativaModel{corpo: $corpo, correta: $correta}';
  }
}