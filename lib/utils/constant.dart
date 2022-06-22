import 'package:shared_preferences/shared_preferences.dart';

const int ANIMATED_BODY_MS = 500;
const String baseUrl = "https://ruangumkm.ilmanaf.com";

Future<String> getToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await prefs.getString('token');
  return token?? "";
}

Future<int> getIdUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int idUser = await prefs.getInt('id_user') ?? 0;
  return idUser;
}

Future<String> getUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = await prefs.getString('user_name');
  return userName!;
}