import 'dart:io';

abstract class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {
}

class ProfileUpdateEvent extends ProfileEvent {
  String? nama;
  String? usaha;
  String? alamat;
  String? noHp;
  String? email;
  String? ig;
  String? fb;
  String? shopee;
  String? tokped;
  String? website;
  String? password;
  final File? image;
  
  ProfileUpdateEvent({
    this.nama,
    this.usaha,
    this.alamat,
    this.email,
    this.fb,
    this.ig,
    this.noHp,
    this.shopee,
    this.password,
    this.tokped,
    this.website,
    this.image
  });
}