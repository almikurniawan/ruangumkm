import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/peringkat/peringkat_event.dart';
import 'package:online_course/blocs/peringkat/peringkat_state.dart';
import 'package:online_course/models/peringkat.dart';
import 'package:online_course/repositories/peringkatService.dart';

class PeringkatBloc extends Bloc<PeringkatEvent, PeringkatState> {
  PeringkatBloc() : super(PeringkatInitial()){
    on<PeringkatLoadEvent>((event, emit) async{
      emit(PeringkatInitial());

      Map<String, dynamic> data = await PeringkatService().loadPeringkat(event);
      if (data.containsKey("errorCode")) {
        emit(PeringkatErrorState(errorCode: data['errorCode'], errorMessage: data['errorMessage']));
      } else {
        List<Peringkat> peringkat = List.from(data['response'])
            .map<Peringkat>((item) => Peringkat.fromJson(item))
            .toList();

        emit(PeringkatLoadedState(peringkat: peringkat));
      }
    });
  }
}