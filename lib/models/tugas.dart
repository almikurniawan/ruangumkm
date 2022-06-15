class Tugas {
  int? id;
  String? judul;
  String? slug;
  String? slug2;
  String? createdAt;
  int? status;

  Tugas(
      {this.id,
      this.judul,
      this.slug,
      this.slug2,
      this.createdAt,
      this.status});

  Tugas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    slug = json['slug'];
    slug2 = json['slug2'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['slug'] = this.slug;
    data['slug2'] = this.slug2;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}
