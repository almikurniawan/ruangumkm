import 'package:online_course/models/peringkat.dart';

abstract class PeringkatState {}

class PeringkatInitial extends PeringkatState {}

class PeringkatLoadedState extends PeringkatState {
  final List<Peringkat> peringkat;
  PeringkatLoadedState({required this.peringkat});
}

class PeringkatErrorState extends PeringkatState {
  final String errorMessage;
  final int errorCode;
  PeringkatErrorState({required this.errorMessage, required this.errorCode});
}