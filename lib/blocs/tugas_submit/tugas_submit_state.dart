import 'package:flutter/cupertino.dart';
import 'package:online_course/models/soal.dart';
import 'package:online_course/models/tugas.dart';

abstract class TugasSubmitState {}

class TugasSubmitLoadingState extends TugasSubmitState {}

class TugasSubmitLoadedState extends TugasSubmitState{
  List<Soal>? soal;
  List<dynamic>? jawaban;
  String? judulTugas;
  int? idEvent;
  List<String>? jawabanPeserta;
  List<TextEditingController>? jawabanController = [];

  TugasSubmitLoadedState({this.soal, this.jawaban, this.judulTugas, this.idEvent, this.jawabanPeserta, this.jawabanController});

  TugasSubmitLoadedState copyFrom({List<Soal>? soal, List<dynamic>? jawaban, String? judulTugas, int? idEvent}) {
    return TugasSubmitLoadedState(
      soal: soal ?? this.soal,
      jawaban: jawaban ?? this.jawaban,
      judulTugas: judulTugas ?? this.judulTugas,
      idEvent: idEvent ?? this.idEvent,
    );
  }

  TugasSubmitLoadedState changeJawabanPeserta(int index, String jawaban) {
    List<String>? jawabanPeserta = this.jawabanPeserta;

    jawabanPeserta![index] = jawaban;
    return TugasSubmitLoadedState(
      soal: this.soal,
      jawaban: this.jawaban,
      judulTugas: this.judulTugas,
      idEvent: this.idEvent,
      jawabanPeserta: jawabanPeserta,
      jawabanController: this.jawabanController,
    );
  }
}

class TugasSubmitFinishState extends TugasSubmitState {}