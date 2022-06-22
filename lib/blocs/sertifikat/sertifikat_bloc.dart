import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_event.dart';
import 'package:online_course/blocs/sertifikat/sertifikat_state.dart';
import 'package:online_course/models/sertifikat_model.dart';
import 'package:online_course/repositories/sertifikatService.dart';

class SertifikatBloc extends Bloc<SertifikatEvent, SertifikatState> {
  SertifikatBloc()
      : super(SertifikatStateLoad(
            kelas: [],
            statusLoading: true,
            order: 'terbaru',
            page: 1,
            totalPage: 1,
            type: 'Tertutup')) {
    on<SertifikatEventLoad>((event, emit) async {
      if (state is SertifikatStateLoad) {
        SertifikatStateLoad currentState = state as SertifikatStateLoad;
        currentState = currentState.copyFrom(statusLoading: true);
        if (event.type != null) {
          currentState = currentState.copyFrom(type: event.type);
        }
        if (event.order != null) {
          currentState = currentState.copyFrom(order: event.order);
        }
        emit(currentState);
        Map<String, dynamic> data = await SertifikatService().loadKelas(event);
        if (data.containsKey('errorCode')) {
          emit(SertifikatErrorState(data['errorCode'], data['errorMessage']));
        } else {
          List<SertifikatModel> _kelas = List.from(data['data'])
              .map((item) => SertifikatModel.fromJson(item))
              .toList();
          currentState = currentState.copyFrom(
              kelas: _kelas,
              statusLoading: false,
              page: data['current_page'],
              totalPage: data['last_page']);
          if (event.order != null)
            currentState = currentState.copyFrom(order: event.order);
          if (event.type != null)
            currentState = currentState.copyFrom(type: event.type);
          emit(currentState);
        }
      }
    });
  }
}
