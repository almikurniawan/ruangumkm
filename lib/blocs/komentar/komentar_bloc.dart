import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_course/blocs/komentar/komentar_event.dart';
import 'package:online_course/blocs/komentar/komentar_state.dart';
import 'package:online_course/models/Komentar.dart';
import 'package:online_course/repositories/komentarService.dart';

class KomentarBloc extends Bloc<KomentarEvent, KomentarState> {
  KomentarBloc() : super(KomentarLoadedState(komentars: [])) {
    on<KomentarLoadEvent>((event, emit) async{

      Map<String, dynamic> komentar = await KomentarService().loadKomentar(event);
      if(komentar.containsKey("errorCode")){

      }else{
        List<Komentar> komentars = komentar['response'].map<Komentar>((json) => Komentar.fromJson(json)).toList();
        emit(KomentarLoadedState(komentars: komentars, isError: false, errorMessage: ''));
      }
    });

    on<KomentarAddEvent>((event, emit) async {
      Map<String, dynamic> sendKomen = await KomentarService().sendKomen(event);
      KomentarLoadedState curState = state as KomentarLoadedState;
    });
  }
}
