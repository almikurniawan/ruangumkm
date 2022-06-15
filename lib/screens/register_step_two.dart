import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_course/blocs/register/register_bloc.dart';
import 'package:online_course/blocs/register/register_event.dart';
import 'package:online_course/blocs/register/register_state.dart';
import 'package:online_course/theme/color.dart';

class RegisterStep2 extends StatefulWidget {
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
  const RegisterStep2(
      {Key? key,
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
      required this.password})
      : super(key: key);

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  File? _image;
  TextEditingController nama = TextEditingController();
  late RegisterBloc _blocRegister;

  @override
  void initState() {
    super.initState();
    nama.text = widget.nama;
    _blocRegister = BlocProvider.of<RegisterBloc>(context);
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
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state){
        if(state is RegisterFinished){
          if(state.errorCode==0){
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register Step 2",
              style: Theme.of(context).textTheme.subtitle2),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pilih Foto Profil",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: _image == null
                      ? ElevatedButton(
                          onPressed: () async {
                            await _onImageButtonPressed();
                          },
                          child: Icon(
                            Icons.add_a_photo,
                            size: 130,
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 200),
                              shape: CircleBorder()),
                        )
                      : Stack(children: [
                          CircleAvatar(
                            backgroundImage: FileImage(
                              _image!,
                            ),
                            radius: 130,
                          ),
                          Positioned(
                            right: 0,
                            top: 10,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _onImageButtonPressed();
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                size: 20,
                              ),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(40, 40),
                                  shape: CircleBorder()),
                            ),
                          )
                        ]),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: nama,
                  decoration: InputDecoration(
                    hintText: "Nama Kamu",
                  ),
                ),
                BlocBuilder(builder: (context, state) {
                  if(state is RegisterFinished){
                    if(state.errorCode==1){
                      return Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                  }
                  return Container();
                }, bloc: _blocRegister),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _blocRegister.add(RegisterButtonPressed(nama: nama.text, usaha: widget.usaha, alamat: widget.alamat, hp: widget.hp, email: widget.email, instagram: widget.instagram, facebook: widget.facebook, shopee: widget.shopee, tokped: widget.tokped, website: widget.website, username: widget.username, password: widget.password, image: _image));
                    },
                    child: Text("Next",
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                    style: ElevatedButton.styleFrom(
                        primary: primary, padding: EdgeInsets.all(20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
