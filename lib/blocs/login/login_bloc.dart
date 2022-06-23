import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/login/login_event.dart';
import 'package:online_course/blocs/login/login_state.dart';
import 'package:online_course/repositories/loginService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState){

    on<LoginButtonPressed>((event, emit) async {
      emit(LoginInitial());

      Map<String, dynamic> login = await LoginService().login(event.username, event.password);
      if(login['errorCode']==0){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', login['token']);
        await prefs.setInt("id_user", login['id_user']);
        await prefs.setString("user_name", login['name']);
        bool? hasToken = await prefs.containsKey('token');
        print("Punya token");
        print(hasToken);
      }
      emit(LoginFinished(errorCode: login['errorCode'], errorMessage: login['errorMessage']));
      
    });

    on<Logout>((event, emit) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await LoginService().logout();
      await prefs.remove("token");
      emit(LogoutFinished(errorCode: 0, errorMessage: ""));
    });

  }


}