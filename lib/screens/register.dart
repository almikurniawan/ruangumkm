import 'package:flutter/material.dart';
import 'package:online_course/screens/login.dart';
import 'package:online_course/screens/register_step_two.dart';
import 'package:online_course/theme/animation.dart';
import 'package:online_course/theme/color.dart';
import 'package:online_course/widgets/contant.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nama = TextEditingController();
  TextEditingController usaha = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController hp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController shopee = TextEditingController();
  TextEditingController tokped = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final feature = ["Login", "Registrasi"];

  int i = 1;

  @override
  // ignore: unnecessary_statements
  Widget build(BuildContext context) {
    void pickImage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterStep2(
              alamat: alamat.text,
              email: email.text,
              facebook: facebook.text,
              hp: hp.text,
              instagram: instagram.text,
              nama: nama.text,
              password: password.text,
              shopee: shopee.text,
              tokped: tokped.text,
              usaha: usaha.text,
              website: website.text,
              username: username.text),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Color(0xfffdfdfdf),
          body: i == 1
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            // TabBar Code
                            Row(children: [
                              Container(
                                height: height / 10,
                                width: width / 2,
                                child: TopAnime(
                                  2,
                                  5,
                                  child: ListView.builder(
                                    itemCount: feature.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            i = index;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(
                                                feature[index],
                                                style: TextStyle(
                                                  color: i == index
                                                      ? Colors.black
                                                      : Colors.grey,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            i == index
                                                ? Container(
                                                    height: 3,
                                                    width: width / 9,
                                                    color: Colors.black,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),

                              // Profile
                              RightAnime(
                                1,
                                15,
                                curve: Curves.easeInOutQuad,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    // color: Colors.red[400],
                                    child: Image(
                                      image: NetworkImage(
                                          "https://ruangumkm.ilmanaf.com/public/img/default/launcher.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ]),

                            SizedBox(
                              height: 30,
                            ),

                            // Top Text
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              width: width,
                              child: TopAnime(
                                1,
                                20,
                                curve: Curves.fastOutSlowIn,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Selamat Datang ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "OnBoarding,",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Masukkan informasi anda untuk \nmelakukan pendaftaran",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            // TextFiled
                            Container(
                              width: width / 1.2,
                              // height: height,
                              child: TopAnime(
                                1,
                                16,
                                curve: Curves.easeInExpo,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: nama,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Nama",
                                        hintText: "Jaya Hartono",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: usaha,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Usaha",
                                        hintText: "Percetakan",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: alamat,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Alamat",
                                        hintText: "Dsn. Manukan Ds. Jabon",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: hp,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "No. Hp",
                                        hintText: "085745451236",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: email,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Email",
                                        hintText: "contoh@gmail.com",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: instagram,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Instagram",
                                        hintText:
                                            "www.instagram.com/jayahartono",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: facebook,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Facebook",
                                        hintText:
                                            "www.facebook.com/jayahartono",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: shopee,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Shopee",
                                        hintText: "www.shopee.com/jayahartono",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: tokped,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Tokopedia",
                                        hintText: "www.shopee.com/jayahartono",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: website,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Website",
                                        hintText: "www.google.com",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: username,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Username",
                                        hintText: "Username",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    TextField(
                                      // readOnly: true, // * Just for Debug
                                      cursorColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      showCursor: true,
                                      controller: password,
                                      //cursorColor: mainColor,
                                      decoration:
                                          kTextFiledInputDecoration.copyWith(
                                        labelText: "Password",
                                        hintText: "*********",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          pickImage();
                                        },
                                        child: Text(
                                          "REGISTER",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(
                                                TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: secondary,
                                          padding: EdgeInsets.all(20),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 5,
                                    ),

                                    // FaceBook and Google ICon
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Login(),
        ),
      ),
    );
  }
}
