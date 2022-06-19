import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/profile/profile_event.dart';
import 'package:online_course/blocs/profile/profile_state.dart';
import 'package:online_course/models/profile_model.dart';
import 'package:online_course/repositories/profile_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()){
    on<ProfileLoadEvent>((event, emit) async{
      emit(ProfileInitial());
      Map<String, dynamic> profile = await ProfileService().loadProfile();
      emit(ProfileLoadedState(ProfileModel.fromJson(profile)));
    });

    on<ProfileUpdateEvent>((event, emit) async{
      Map<String, dynamic> res = await ProfileService().update(event);
      print(res);
    });
  }
  
}