class Komentar {
  String? namaFasilitator;
  String? fotoFasilitator;
  String? fotoAnggota;
  String? namaPeserta;
  String? komentar;
  String? tanggal;
  String? aksi;

  Komentar(
      {this.namaFasilitator,
      this.fotoFasilitator,
      this.fotoAnggota,
      this.namaPeserta,
      this.komentar,
      this.tanggal,
      this.aksi});

  Komentar.fromJson(Map<String, dynamic> json) {
    namaFasilitator = json['nama_fasilitator'];
    fotoFasilitator = json['foto_fasilitator'];
    fotoAnggota = json['foto_anggota'];
    namaPeserta = json['nama_peserta'];
    komentar = json['komentar'];
    tanggal = json['tanggal'];
    aksi = json['aksi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_fasilitator'] = this.namaFasilitator;
    data['foto_fasilitator'] = this.fotoFasilitator;
    data['foto_anggota'] = this.fotoAnggota;
    data['nama_peserta'] = this.namaPeserta;
    data['komentar'] = this.komentar;
    data['tanggal'] = this.tanggal;
    data['aksi'] = this.aksi;
    return data;
  }
}