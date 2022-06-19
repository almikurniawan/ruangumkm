import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_event.dart';
import 'package:online_course/blocs/tugas_submit/tugas_submit_state.dart';
import 'package:online_course/models/soal.dart';
import 'package:online_course/repositories/tugasService.dart';

class TugasSubmitBloc extends Bloc<TugasSubmitEvent, TugasSubmitState> {
  TugasSubmitBloc() : super(TugasSubmitLoadingState()) {
    on<TugasSubmitFinishSuntingEvent>((event, emit) async {
      if (state is TugasSubmitLoadedState) {
        TugasSubmitLoadedState state = this.state as TugasSubmitLoadedState;
        int idEvent = state.idEvent!;
        String judulTugas = state.judulTugas!;

        Map<dynamic, dynamic> requestData = new Map<String, dynamic>();
        requestData['id_event'] = idEvent;
        requestData['judul_tugas'] = judulTugas;
        List jawaban = <Map<dynamic, dynamic>>[];

        for (var i = 1; i <= state.soal!.length; i++) {
          if (state.soal![i - 1].value == 'text') {
            jawaban.add({
              'id_soal': state.soal![i - 1].id,
              'jawaban': state.jawabanController![i - 1].text
            });
          } else {
            jawaban.add({
              'id_soal': state.soal![i - 1].id,
              'jawaban': state.jawabanPeserta![i - 1]
            });
          }
        }
        requestData['key'] = jawaban;
        Map<String, dynamic> res =
            await TugasService().sendSuntingJawaban(requestData);
        emit(TugasSubmitFinishState());
      }
    });

    on<TugasSubmitFinishEvent>((event, emit) async {
      if (state is TugasSubmitLoadedState) {
        TugasSubmitLoadedState state = this.state as TugasSubmitLoadedState;
        int idEvent = state.idEvent!;
        String judulTugas = state.judulTugas!;

        Map<dynamic, dynamic> requestData = new Map<String, dynamic>();
        requestData['id_event'] = idEvent;
        requestData['judul_tugas'] = judulTugas;
        List jawaban = <Map<dynamic, dynamic>>[];

        for (var i = 1; i <= state.soal!.length; i++) {
          jawaban.add({
            'id_soal': state.soal![i - 1].id,
            'jawaban': state.jawabanPeserta![i - 1]
          });
        }
        requestData['key'] = jawaban;
        Map<String, dynamic> res =
            await TugasService().sendJawaban(requestData);
        emit(TugasSubmitFinishState());
      }
    });

    on<TugasSubmitChangeJawabanevent>((event, emit) {
      if (state is TugasSubmitLoadedState) {
        TugasSubmitLoadedState curState = state as TugasSubmitLoadedState;
        emit(curState.changeJawabanPeserta(event.index, event.jawaban));
      }
    });

    on<TugasSubmitLoadEvent>((event, emit) async {
      emit(TugasSubmitLoadingState());
      Map<String, dynamic> dataSoal = await TugasService().loadSoal(event);
      List<Soal> soals = List.from(dataSoal['soal'])
          .map<Soal>((item) => Soal.fromJson(item))
          .toList();

      List<String> jawabanPeserta = soals.map((e) {
        return "";
      }).toList();

      List<dynamic> jawabans = List.from(dataSoal['jawaban']);
      if (dataSoal.containsKey("errorCode")) {
      } else {
        emit(TugasSubmitLoadedState(
            idEvent: dataSoal['id_event'],
            soal: soals,
            jawaban: jawabans,
            judulTugas: dataSoal['judul_tugas'],
            jawabanPeserta: jawabanPeserta));
      }
    });

    on<TugasSubmitLoadSuntingEvent>((event, emit) async {
      emit(TugasSubmitLoadingState());
      Map<String, dynamic> dataSoal =
          await TugasService().loadSuntingSoal(event);
      List<Soal> soals = List.from(dataSoal['soal'])
          .map<Soal>((item) => Soal.fromJson(item))
          .toList();

      List<String> jawabanPeserta = dataSoal['jawaban'].map<String>((e) {
        return e.toString();
      }).toList();

      List<TextEditingController> controller = dataSoal['jawaban'].map<TextEditingController>((e) {
        return TextEditingController(text: e.toString());
      }).toList();

      List<dynamic> jawabans = List.from(dataSoal['option']);
      if (dataSoal.containsKey("errorCode")) {
      } else {
        emit(TugasSubmitLoadedState(
            idEvent: dataSoal['id_event'],
            soal: soals,
            jawaban: jawabans,
            judulTugas: dataSoal['judul_tugas'],
            jawabanPeserta: jawabanPeserta,
            jawabanController: controller));
      }
    });

    on<TugasSubmitLoadReviewEvent>((event, emit) async{
      emit(TugasSubmitLoadingState());
      Map<String, dynamic> data = await TugasService().loadReview(event);
      print(data);

      List<Soal> soals = List.from(data['soal'])
          .map<Soal>((item) => Soal.fromJson(item))
          .toList();

      List<String> jawabanPeserta = data['jawaban'].map<String>((e) {
        return e.toString();
      }).toList();

      List<TextEditingController> controller = data['jawaban'].map<TextEditingController>((e) {
        return TextEditingController(text: e.toString());
      }).toList();

      if (data.containsKey("errorCode")) {
      } else {
        emit(TugasSubmitLoadedState(
            idEvent: data['id_event'],
            soal: soals,
            jawaban: [],
            judulTugas: data['judul_tugas'],
            jawabanPeserta: jawabanPeserta,
            jawabanController: controller));
      }
    });
  }
}
