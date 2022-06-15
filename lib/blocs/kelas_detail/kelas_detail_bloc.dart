import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_event.dart';
import 'package:online_course/blocs/kelas_detail/kelas_detail_state.dart';
import 'package:online_course/models/DetailKelasModel.dart';
import 'package:online_course/models/kelas.dart';
import 'package:online_course/repositories/kelasDetailService.dart';

class KelasDetailBloc extends Bloc<KelasDetailEvent, KelasDetailState> {
  KelasDetailBloc() : super(KelasDetailInitialState()){
    on<KelasDetailLoadEvent>((event, emit) async{
      emit(KelasDetailLoadingState());
      Map<String, dynamic> data = await KelasDetailService().loadKelas(event);
      // print(data);
      if(data.containsKey('errorCode')){

      }else{
        List<Kelas> eventBaru = data['event_baru'].map<Kelas>((item) => Kelas.fromJson(item)).toList();
        List<Kelas> eventTerkait = data['event_terkait'].map<Kelas>((e) => Kelas.fromJson(e)).toList();
        Detail kelas = Detail.fromJson(data['event']);
        emit(KelasDetailLoadedState(
          eventBaru: eventBaru,
          eventTerkait: eventTerkait,
          event: kelas
        ));
      }
    });
  }
}