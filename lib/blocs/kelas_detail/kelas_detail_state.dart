import 'package:online_course/models/DetailKelasModel.dart';
import 'package:online_course/models/kelas.dart';

abstract class KelasDetailState{}

class KelasDetailInitialState extends KelasDetailState{}

class KelasDetailLoadingState extends KelasDetailState{}

class KelasDetailLoadedState extends KelasDetailState{
  final List<Kelas>? eventBaru;
	final List<Kelas>? eventTerkait;
	final Detail? event;
  KelasDetailLoadedState({this.eventBaru, this.eventTerkait, this.event});
}

class KelasDetailErrorState extends KelasDetailState{
    final int errorCode;
    final String errorMessage;
    KelasDetailErrorState({required this.errorCode, required this.errorMessage});
}
