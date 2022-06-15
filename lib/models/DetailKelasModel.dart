import 'package:online_course/models/kelas.dart';

class Detail {
	String? name;
	int? id;
	String? namaEvent;
	String? tanggalMulai;
	String? tanggalSelesai;
	int? selisihHari;
	String? fotoEvent;
	String? tipe;
	String? deskripsi;
	String? createdAt;
	String? fotoFasilitator;
	int? jumlahMateri;
	int? jumlahPeserta;
	List<String>? tag;
	String? slug;
	String? emailFasilitator;
	String? jenis;
	ExtraFasilitator? extraFasilitator;
	List<ExtraMateri>? extraMateri;
	List<String>? extraTopik;
	List<ExtraPeringkat>? extraPeringkat;
	Map<String, dynamic>? arrIdUserPeserta;

	Detail({this.name, this.id, this.namaEvent, this.tanggalMulai, this.tanggalSelesai, this.selisihHari, this.fotoEvent, this.tipe, this.deskripsi, this.createdAt, this.fotoFasilitator, this.jumlahMateri, this.jumlahPeserta, this.tag, this.slug, this.emailFasilitator, this.jenis, this.extraFasilitator, this.extraMateri, this.extraTopik, this.extraPeringkat, this.arrIdUserPeserta});

	Detail.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
		namaEvent = json['nama_event'];
		tanggalMulai = json['tanggal_mulai'];
		tanggalSelesai = json['tanggal_selesai'];
		selisihHari = json['selisih_hari'];
		fotoEvent = json['foto_event'];
		tipe = json['tipe'];
		deskripsi = json['deskripsi'];
		createdAt = json['created_at'];
		fotoFasilitator = json['foto_fasilitator'];
		jumlahMateri = json['jumlah_materi'];
		jumlahPeserta = json['jumlah_peserta'];
		tag = json['tag'].cast<String>();
		slug = json['slug'];
		emailFasilitator = json['email_fasilitator'];
		jenis = json['jenis'];
		extraFasilitator = json['extraFasilitator'] != null ? new ExtraFasilitator.fromJson(json['extraFasilitator']) : null;
		if (json['extraMateri'] != null) {
			extraMateri = <ExtraMateri>[];
			json['extraMateri'].forEach((v) { extraMateri!.add(new ExtraMateri.fromJson(v)); });
		}
		if (json['extraPeringkat'] != null) {
			extraPeringkat = <ExtraPeringkat>[];
			json['extraPeringkat'].forEach((v) { extraPeringkat!.add(new ExtraPeringkat.fromJson(v)); });
		}
		arrIdUserPeserta = json['arr_id_user_peserta'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		data['nama_event'] = this.namaEvent;
		data['tanggal_mulai'] = this.tanggalMulai;
		data['tanggal_selesai'] = this.tanggalSelesai;
		data['selisih_hari'] = this.selisihHari;
		data['foto_event'] = this.fotoEvent;
		data['tipe'] = this.tipe;
		data['deskripsi'] = this.deskripsi;
		data['created_at'] = this.createdAt;
		data['foto_fasilitator'] = this.fotoFasilitator;
		data['jumlah_materi'] = this.jumlahMateri;
		data['jumlah_peserta'] = this.jumlahPeserta;
		data['tag'] = this.tag;
		data['slug'] = this.slug;
		data['email_fasilitator'] = this.emailFasilitator;
		data['jenis'] = this.jenis;
		if (this.extraFasilitator != null) {
      data['extraFasilitator'] = this.extraFasilitator!.toJson();
    }
		if (this.extraMateri != null) {
      data['extraMateri'] = this.extraMateri!.map((v) => v.toJson()).toList();
    }
		if (this.extraPeringkat != null) {
      data['extraPeringkat'] = this.extraPeringkat!.map((v) => v.toJson()).toList();
    }
		if (this.arrIdUserPeserta != null) {
      data['arr_id_user_peserta'] = this.arrIdUserPeserta!;
    }
		return data;
	}
}

class ExtraFasilitator {
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
	String? deskripsi;

	ExtraFasilitator({this.id, this.userId, this.nama, this.usaha, this.alamat, this.noHp, this.instagram, this.facebook, this.tokopedia, this.shopee, this.website, this.deskripsi});

	ExtraFasilitator.fromJson(Map<String, dynamic> json) {
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
		deskripsi = json['deskripsi'];
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
		data['deskripsi'] = this.deskripsi;
		return data;
	}
}

class ExtraMateri {
	int? id;
	int? idUser;
	String? judul;
	String? deskripsi;
	String? file;
	String? linkMateri;
	String? tag;
	String? gambar;
	String? umum;
	String? status;
	String? createdAt;
	String? updatedAt;

	ExtraMateri({this.id, this.idUser, this.judul, this.deskripsi, this.file, this.linkMateri, this.tag, this.gambar, this.umum, this.status, this.createdAt, this.updatedAt});

	ExtraMateri.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		idUser = json['id_user'];
		judul = json['judul'];
		deskripsi = json['deskripsi'];
		file = json['file'];
		linkMateri = json['link_materi'];
		tag = json['tag'];
		gambar = json['gambar'];
		umum = json['umum'];
		status = json['status'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['id_user'] = this.idUser;
		data['judul'] = this.judul;
		data['deskripsi'] = this.deskripsi;
		data['file'] = this.file;
		data['link_materi'] = this.linkMateri;
		data['tag'] = this.tag;
		data['gambar'] = this.gambar;
		data['umum'] = this.umum;
		data['status'] = this.status;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}


class ExtraPeringkat {
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

	ExtraPeringkat({this.id, this.name, this.email, this.username, this.rememberToken, this.level, this.foto, this.status, this.createdAt, this.updatedAt, this.limitName, this.jumlahSertifikat});

	ExtraPeringkat.fromJson(Map<String, dynamic> json) {
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
		return data;
	}
}