class Fasilitator {
  String? name;
  String? facebook;
  String? instagram;
  String? foto;
  String? limitName;

  Fasilitator(
      {this.name, this.facebook, this.instagram, this.foto, this.limitName});

  Fasilitator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    foto = json['foto'];
    limitName = json['limit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['foto'] = this.foto;
    data['limit_name'] = this.limitName;
    return data;
  }
}