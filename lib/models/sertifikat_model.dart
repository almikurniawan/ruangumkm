class SertifikatModel {
  int? id;
  int? idFasilitator;
  String? namaEvent;
  String? slug;
  String? tanggalMulai;
  String? tanggalSelesai;
  String? fotoEvent;
  String? thumbnail;
  String? tipe;
  String? deskripsi;
  String? jenis;
  String? sertifikat;
  String? arsip;
  String? createdAt;
  String? updatedAt;
  String? limitKelasName;

  SertifikatModel(
      {this.id,
      this.idFasilitator,
      this.namaEvent,
      this.slug,
      this.tanggalMulai,
      this.tanggalSelesai,
      this.fotoEvent,
      this.thumbnail,
      this.tipe,
      this.deskripsi,
      this.jenis,
      this.sertifikat,
      this.arsip,
      this.createdAt,
      this.updatedAt,
      this.limitKelasName});

  SertifikatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFasilitator = json['id_fasilitator'];
    namaEvent = json['nama_event'];
    slug = json['slug'];
    tanggalMulai = json['tanggal_mulai'];
    tanggalSelesai = json['tanggal_selesai'];
    fotoEvent = json['foto_event'];
    thumbnail = json['thumbnail'];
    tipe = json['tipe'];
    deskripsi = json['deskripsi'];
    jenis = json['jenis'];
    sertifikat = json['sertifikat'];
    arsip = json['arsip'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    limitKelasName = json['limit_kelas_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_fasilitator'] = this.idFasilitator;
    data['nama_event'] = this.namaEvent;
    data['slug'] = this.slug;
    data['tanggal_mulai'] = this.tanggalMulai;
    data['tanggal_selesai'] = this.tanggalSelesai;
    data['foto_event'] = this.fotoEvent;
    data['thumbnail'] = this.thumbnail;
    data['tipe'] = this.tipe;
    data['deskripsi'] = this.deskripsi;
    data['jenis'] = this.jenis;
    data['sertifikat'] = this.sertifikat;
    data['arsip'] = this.arsip;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['limit_kelas_name'] = this.limitKelasName;
    return data;
  }
}

class SertifikatModelPeserta {
  int? id;
  int? idEvent;
  int? idUser;
  String? fileSertifikat;

  SertifikatModelPeserta(
      {this.id, this.idEvent, this.idUser, this.fileSertifikat});

  SertifikatModelPeserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idEvent = json['nama_event'];
    idUser = json['foto_event'];
    fileSertifikat = json['file_sertifikat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_event'] = this.idEvent;
    data['foto_event'] = this.idUser;
    data['file_sertifikat'] = this.fileSertifikat;
    return data;
  }
}
