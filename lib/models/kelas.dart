class Kelas {
  String? name;
  int? id;
  String? namaEvent;
  String? tanggalMulai;
  String? tanggalSelesai;
  int? selisihHari;
  // String? upcomingText;
  String? fotoEvent;
  String? tipe;
  String? deskripsi;
  String? createdAt;
  String? fotoFasilitator;
  int? jumlahMateri;
  int? jumlahPeserta;
  List<String>? tag;
  String? slug;
  String? jenis;

  Kelas(
      {this.name,
      this.id,
      this.namaEvent,
      this.tanggalMulai,
      this.tanggalSelesai,
      this.selisihHari,
      // this.upcomingText,
      this.fotoEvent,
      this.tipe,
      this.deskripsi,
      this.createdAt,
      this.fotoFasilitator,
      this.jumlahMateri,
      this.jumlahPeserta,
      this.tag,
      this.slug,
      this.jenis});

  Kelas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    namaEvent = json['nama_event'];
    tanggalMulai = json['tanggal_mulai'];
    tanggalSelesai = json['tanggal_selesai'];
    selisihHari = json['selisih_hari'];
    // upcomingText = json['upcoming_text'] ?? "";
    fotoEvent = json['foto_event'];
    tipe = json['tipe'];
    deskripsi = json['deskripsi'];
    createdAt = json['created_at'];
    fotoFasilitator = json['foto_fasilitator'];
    jumlahMateri = json['jumlah_materi'];
    jumlahPeserta = json['jumlah_peserta'];
    tag = json['tag'].cast<String>();
    slug = json['slug'];
    jenis = json['jenis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['nama_event'] = this.namaEvent;
    data['tanggal_mulai'] = this.tanggalMulai;
    data['tanggal_selesai'] = this.tanggalSelesai;
    data['selisih_hari'] = this.selisihHari;
    // data['upcoming_text'] = this.upcomingText;
    data['foto_event'] = this.fotoEvent;
    data['tipe'] = this.tipe;
    data['deskripsi'] = this.deskripsi;
    data['created_at'] = this.createdAt;
    data['foto_fasilitator'] = this.fotoFasilitator;
    data['jumlah_materi'] = this.jumlahMateri;
    data['jumlah_peserta'] = this.jumlahPeserta;
    data['tag'] = this.tag;
    data['slug'] = this.slug;
    data['jenis'] = this.jenis;
    return data;
  }
}
