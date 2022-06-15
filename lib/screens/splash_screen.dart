import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_course/screens/root_app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  navigateToMain(BuildContext context) async {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RootApp())));
  }

  @override
  Widget build(BuildContext context) {
    navigateToMain(context);

    return Scaffold(
      body: Center(
        // child: SvgPicture.asset('assets/icons/splash.svg'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 110,
            height: 110,
            // color: Colors.red[400],
            child: Image(
              image: NetworkImage(
                  "https://ruangumkm.ilmanaf.com/public/img/default/launcher.png"),
            ),
          ),
        ),
      ),
    );
  }
}
