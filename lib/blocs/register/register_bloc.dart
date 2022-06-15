import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/register/register_event.dart';
import 'package:online_course/blocs/register/register_state.dart';
import 'package:online_course/repositories/registerService.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterState initialState) : super(initialState) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterInitial());
      Map<String, dynamic> register = await RegisterService().register(event);
      if(register.containsKey("errorCode")){
        emit(RegisterFinished(errorCode: register['errorCode'], errorMessage: register['errorMessage']+' Periksa Kembali Biodata anda.'));
      }else{
        emit(RegisterFinished(errorCode: 0, errorMessage: 'Sukses registrasi.'));
      }
    });
  }
}
