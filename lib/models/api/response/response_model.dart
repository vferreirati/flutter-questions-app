class ResponseModel<T> {
  List<String> errors;
  T data;
  bool success;

  ResponseModel({this.data, this.errors, this.success});

  static ResponseModel<T> fromJson<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) objectFromJson) {
    var model = ResponseModel<T>();

    model.success = json["sucesso"];

    if(json["erros"] != null) {
      var errorList = json["erros"] as List;
      model.errors = errorList.isNotEmpty ? errorList : List<String>();
    }

    if(json["item"] != null) {
      model.data = objectFromJson(json["item"]);
    }

    return model;
  }
}