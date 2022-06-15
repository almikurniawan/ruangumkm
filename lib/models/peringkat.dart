class Peringkat {
  int? id;
  String? name;
  String? penilaian;

  Peringkat({this.id, this.name, this.penilaian});

  Peringkat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    penilaian = json['penilaian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['penilaian'] = this.penilaian;
    return data;
  }
}
