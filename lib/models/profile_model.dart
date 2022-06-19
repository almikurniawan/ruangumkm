class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? rememberToken;
  String? level;
  String? foto;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? limitName;
  int? jumlahSertifikat;
  ProfilPeserta? profilPeserta;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.rememberToken,
      this.level,
      this.foto,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.limitName,
      this.jumlahSertifikat,
      this.profilPeserta});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    rememberToken = json['remember_token'];
    level = json['level'];
    foto = json['foto'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    limitName = json['limit_name'];
    jumlahSertifikat = json['jumlah_sertifikat'];
    profilPeserta = json['profil_peserta'] != null
        ? new ProfilPeserta.fromJson(json['profil_peserta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['remember_token'] = this.rememberToken;
    data['level'] = this.level;
    data['foto'] = this.foto;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['limit_name'] = this.limitName;
    data['jumlah_sertifikat'] = this.jumlahSertifikat;
    if (this.profilPeserta != null) {
      data['profil_peserta'] = this.profilPeserta!.toJson();
    }
    return data;
  }
}

class ProfilPeserta {
  int? id;
  int? userId;
  String? nama;
  String? usaha;
  String? alamat;
  String? noHp;
  String? instagram;
  String? facebook;
  String? tokopedia;
  String? shopee;
  String? website;

  ProfilPeserta(
      {this.id,
      this.userId,
      this.nama,
      this.usaha,
      this.alamat,
      this.noHp,
      this.instagram,
      this.facebook,
      this.tokopedia,
      this.shopee,
      this.website});

  ProfilPeserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nama = json['nama'];
    usaha = json['usaha'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    tokopedia = json['tokopedia'];
    shopee = json['shopee'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['nama'] = this.nama;
    data['usaha'] = this.usaha;
    data['alamat'] = this.alamat;
    data['no_hp'] = this.noHp;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['tokopedia'] = this.tokopedia;
    data['shopee'] = this.shopee;
    data['website'] = this.website;
    return data;
  }
}
