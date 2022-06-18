class Soal {
  int? id;
  String? soal;
  String? value;

  Soal({this.id, this.soal, this.value});

  Soal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soal = json['soal'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['soal'] = this.soal;
    data['value'] = this.value;
    return data;
  }
}