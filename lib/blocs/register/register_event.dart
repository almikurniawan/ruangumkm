import 'dart:io';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String nama;
  final String usaha;
  final String alamat;
  final String hp;
  final String email;
  final String instagram;
  final String facebook;
  final String shopee;
  final String tokped;
  final String website;
  final String username;
  final String password;
  final File? image;

  RegisterButtonPressed({
    required this.nama,
    required this.usaha,
    required this.alamat,
    required this.hp,
    required this.email,
    required this.instagram,
    required this.facebook,
    required this.shopee,
    required this.tokped,
    required this.website,
    required this.username,
    required this.password,
    this.image
  });

}