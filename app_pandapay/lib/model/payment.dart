class Payment {
  int id;
  String type;
  String value;
  String idUser;

  Payment({this.id, this.type, this.value, this.idUser});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['value'] = this.value;
    data['id_user'] = this.idUser;
    return data;
  }
}