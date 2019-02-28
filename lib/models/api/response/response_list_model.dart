class ResponseListModel<T> {
  List<T> data;
  List<String> errors;
  bool success;

  ResponseListModel({this.data, this.errors, this.success});
  ResponseListModel.noConnection() {
    success = false;
    errors = ["Sem conexão com a internet"];
  }
  ResponseListModel.requestError() {
    success = false;
    errors = ["Erro ao se comunicar com o servidor"];
  }
  ResponseListModel.success(List<T> items) {
    success = true;
    errors = [];
    data = items;
  }

  static ResponseListModel<T> fromJson<T>(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) objectFromJson) {
    var model = ResponseListModel<T>();

    model.success = json["sucesso"];

    if (json["erros"] != null) {
      var errorsList = json["erros"] as List;
      model.errors = errorsList.isNotEmpty ? errorsList : List<String>();
    }

    if (json["itens"] != null)
      model.data = (json["itens"] as List)
          .map((element) => objectFromJson(element))
          .toList();

    return model;
  }
}
