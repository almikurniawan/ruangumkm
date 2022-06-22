import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:online_course/blocs/chat/chat_bloc.dart';
import 'package:online_course/blocs/dashboard/dashboard_bloc.dart';
import 'package:online_course/blocs/dashboard/dashboard_state.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_bloc.dart';
import 'package:online_course/blocs/kelas_saya/kelas_bloc.dart';
import 'package:online_course/blocs/kelas_saya/kelas_bloc_all.dart';
import 'package:online_course/blocs/komentar/komentar_bloc.dart';
import 'package:online_course/blocs/login/login_bloc.dart';
import 'package:online_course/blocs/login/login_state.dart';
import 'package:online_course/blocs/peringkat/peringkat_bloc.dart';
import 'package:online_course/blocs/profile/profile_bloc.dart';
import 'package:online_course/blocs/register/register_bloc.dart';
import 'package:online_course/blocs/register/register_state.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_bloc.dart';
import 'package:online_course/blocs/tugas/tugas_bloc.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_bloc.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_event.dart';
import 'package:online_course/screens/splash_screen.dart';
import 'theme/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return LoginBloc(LoginInitial());
        }),
        BlocProvider(create: (BuildContext context) {
          return RegisterBloc(RegisterInitial());
        }),
        BlocProvider(create: (BuildContext context) {
          return DashboardBloc(DashboardLoadState(loading: true));
        }),
        BlocProvider(create: (BuildContext context) {
          return KelasBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return KelasBlocAll();
        }),
        BlocProvider(create: (BuildContext context) {
          return KelasDetailBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return TugasBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return PeringkatBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return ChatBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return KomentarBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return TugasSubmitBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return ProfileBloc();
        }),
        BlocProvider(create: (BuildContext context) {
          return SertifikatBloc();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OnBoarding App',
        theme: ThemeData(
            primaryColor: primary,
            appBarTheme: AppBarTheme(
              color: Colors.white24,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff4a8f9f),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              // labelPadding: EdgeInsets.symmetric(horizontal: 2,),
            ),
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: primary),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 46, fontWeight: FontWeight.bold, color: textColor),
              headline2: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
              subtitle1: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
              subtitle2: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w600, color: textColor),
              bodyText1: TextStyle(fontSize: 16, color: textColor),
            )),
        home: SplashScreen(),
        // home: RootApp(),
      ),
    );
  }
}
