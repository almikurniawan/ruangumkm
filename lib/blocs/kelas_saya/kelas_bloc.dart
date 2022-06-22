import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/kelas_saya/kelas_event.dart';
import 'package:online_course/blocs/kelas_saya/kelas_state.dart';
import 'package:online_course/models/kelas_saya_model.dart';
import 'package:online_course/repositories/kelasService.dart';

class KelasBloc extends Bloc<KelasEvent, KelasState> {
  KelasBloc()
      : super(KelasStateLoad(
            kelas: [],
            statusLoading: true,
            order: 'terbaru',
            page: 1,
            totalPage: 1,
            type: 'Semua')) {

    on<KelasEventLoad>((event, emit) async {
      if (state is KelasStateLoad) {
        KelasStateLoad currentState = state as KelasStateLoad;
        currentState = currentState.copyFrom(statusLoading: true);
        if(event.type != null){
          currentState = currentState.copyFrom(type: event.type);
        }
        if(event.order != null){
          currentState = currentState.copyFrom(order: event.order);
        }
        emit(currentState);
        Map<String, dynamic> data = await KelasService().loadKelas(event);
        if (data.containsKey('errorCode')) {
          emit(KelasErrorState(data['errorCode'], data['errorMessage']));
        } else {
          List<KelasSayaModel> _kelas = List.from(data['items']['data'])
              .map((item) => KelasSayaModel.fromJson(item))
              .toList();
          currentState = currentState.copyFrom(kelas: _kelas, statusLoading: false, page: data['items']['current_page'], totalPage: data['items']['last_page']);
          if(event.order != null) currentState = currentState.copyFrom(order: event.order);
          if(event.type != null) currentState = currentState.copyFrom(type: event.type);
          emit(currentState);
        }
      }
    });
  }
}
