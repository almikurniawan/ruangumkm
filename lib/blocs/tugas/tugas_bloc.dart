import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/login/login_bloc.dart';
import 'package:online_course/blocs/tugas/tugas_event.dart';
import 'package:online_course/blocs/tugas/tugas_state.dart';
import 'package:online_course/models/tugas.dart';
import 'package:online_course/repositories/tugasService.dart';

class TugasBloc extends Bloc<TugasEvent, TugasState> {
  TugasBloc() : super(TugasInitial()) {

    on<TugasLoadEvent>((event, emit) async {
      emit(TugasInitial());

      Map<String, dynamic> data = await TugasService().loadTugas(event);
      if (data.containsKey("errorCode")) {
        emit(TugasErrorState(errorCode: data['errorCode'], errorMessage: data['errorMessage']));

      } else {
        List<Tugas> tugas = List.from(data['response'])
            .map<Tugas>((item) => Tugas.fromJson(item))
            .toList();

        emit(TugasLoadedState(tugas: tugas));
      }
    });
  }
}
