class AlternativaModel {
  String corpo;
  bool correta;

  AlternativaModel({this.corpo, this.correta});

  static AlternativaModel fromJson(Map<String, dynamic> json) {
    var model = AlternativaModel();

    model.corpo = json["corpo"];
    model.correta = json["correta"];

    return model;
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();

    map["corpo"] = this.corpo;
    map["correta"] = this.correta;

    return map;
  }

  @override
  String toString() {
    return 'AlternativaModel{corpo: $corpo, correta: $correta}';
  }
}