import 'package:flutter/material.dart';

abstract class TugasSubmitEvent {}

class TugasSubmitLoadEvent extends TugasSubmitEvent {
  final String slug1;
  final String slug2;
  TugasSubmitLoadEvent({required this.slug1, required this.slug2});
}

class TugasSubmitChangeJawabanevent extends TugasSubmitEvent {
  final int index;
  final String jawaban;
  TugasSubmitChangeJawabanevent({required this.index, required this.jawaban});
}

class TugasSubmitFinishEvent extends TugasSubmitEvent {}

class TugasSubmitFinishSuntingEvent extends TugasSubmitEvent {
}

class TugasSubmitLoadSuntingEvent extends TugasSubmitEvent {
  final String slug1;
  final String slug2;
  TugasSubmitLoadSuntingEvent({required this.slug1, required this.slug2});
}