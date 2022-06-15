import 'package:online_course/models/tugas.dart';

abstract class TugasState{}

class TugasInitial extends TugasState{}

class TugasLoadedState extends TugasState{
  List<Tugas> tugas;
  TugasLoadedState({required this.tugas});
}

class TugasErrorState extends TugasState{
  final int errorCode;
  final String errorMessage;
  TugasErrorState({required this.errorCode, required this.errorMessage});
}