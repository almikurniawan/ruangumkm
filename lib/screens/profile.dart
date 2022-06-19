import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_course/blocs/profile/profile_bloc.dart';
import 'package:online_course/blocs/profile/profile_event.dart';
import 'package:online_course/blocs/profile/profile_state.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/contant.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileBloc _profileBloc;
  TextEditingController nama = TextEditingController();
  TextEditingController usaha = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController ig = TextEditingController();
  TextEditingController fb = TextEditingController();
  TextEditingController shopee = TextEditingController();
  TextEditingController tokped = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController password = TextEditingController();
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(ProfileLoadEvent());
  }

  Future<void> _onImageButtonPressed() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefefef),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Pengaturan Profil',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadedState) {
                  nama.text = state.profile.profilPeserta!.nama!;
                  usaha.text = state.profile.profilPeserta!.usaha!;
                  alamat.text = state.profile.profilPeserta!.alamat!;
                  noHp.text = state.profile.profilPeserta!.noHp!;
                  email.text = state.profile.email!;

                  ig.text = state.profile.profilPeserta!.instagram ?? "";
                  fb.text = state.profile.profilPeserta!.facebook ?? "";
                  shopee.text = state.profile.profilPeserta!.shopee ?? "";
                  tokped.text = state.profile.profilPeserta!.tokopedia ?? "";
                  website.text = state.profile.profilPeserta!.website ?? "";

                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Nama",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: nama,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Usaha",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: usaha,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Alamat",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: alamat,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "No. HP",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                  controller: noHp,
                                  decoration: profileInputDecoration.copyWith(
                                    prefixIcon: Icon(Icons.phone_android),
                                    prefixText: "+62",
                                  ),
                                  keyboardType: TextInputType.phone),
                              SizedBox(height: 20),
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: email,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Social Media",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Link Instagram",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: ig,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Link Facebook",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: fb,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Link Shopee",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: shopee,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Link Tokopedia",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: tokped,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Link Website",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: website,
                                decoration: profileInputDecoration,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Account",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: password,
                                    decoration: profileInputDecoration,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Foto",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(10),
                                            primary: Colors.blue,
                                            shadowColor: Colors.black,
                                            shape: CircleBorder()),
                                        child:
                                            Icon(Icons.photo_camera, size: 30),
                                        onPressed: () async {
                                          await _onImageButtonPressed();
                                        },
                                      )),
                                  SizedBox(height: 20),
                                  (_image==null) ? Container() : 
                                  Center(
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(
                                        _image!,
                                      ),
                                      radius: 130,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(20),
                                        primary: Color(0xffffc78b),
                                        shadowColor: primary,
                                      ),
                                      onPressed: () {
                                        _profileBloc.add(ProfileUpdateEvent(
                                            nama: nama.text,
                                            alamat: alamat.text,
                                            email: email.text,
                                            fb: fb.text,
                                            ig: ig.text,
                                            noHp: noHp.text,
                                            password: password.text,
                                            shopee: shopee.text,
                                            tokped: tokped.text,
                                            usaha: usaha.text,
                                            website: website.text,
                                            image : _image));
                                      },
                                      child: Text("Simpan",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ]))
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
