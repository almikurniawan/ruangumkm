import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/contant.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            Container(
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
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Nama",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Usaha",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Alamat",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "No. HP",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                            decoration: profileInputDecoration.copyWith(
                              prefixIcon: Icon(Icons.phone_android),
                              prefixText: "+62",
                            ),
                            keyboardType: TextInputType.phone),
                        SizedBox(height: 20),
                        Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
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
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Link Instagram",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Link Facebook",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Link Shopee",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Link Tokopedia",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: profileInputDecoration,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Link Website",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        TextField(
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
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                                  shape: CircleBorder()
                                ),
                                child: Icon(Icons.photo_camera, size: 30),
                                onPressed: () {
                                },
                              )
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20),
                                  primary: Color(0xffffc78b),
                                  shadowColor: primary,
                                ),
                                onPressed: () {},
                                child: Text("Simpan", style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                              ),
                            ),
                            SizedBox(height: 20),
                          ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
