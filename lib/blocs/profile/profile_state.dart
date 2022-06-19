import 'package:online_course/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;
  ProfileLoadedState(this.profile);
}

