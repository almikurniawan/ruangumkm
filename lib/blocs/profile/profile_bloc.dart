import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/profile/profile_event.dart';
import 'package:online_course/blocs/profile/profile_state.dart';
import 'package:online_course/models/profile_model.dart';
import 'package:online_course/repositories/profile_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()){
    on<ProileLoadEvent>((event, emit) async{
      Map<String, dynamic> profile = await ProfileService().loadProfile();
      print(profile);
      emit(ProfileLoadedState(ProfileModel.fromJson(profile)));
    });
  }
  
}